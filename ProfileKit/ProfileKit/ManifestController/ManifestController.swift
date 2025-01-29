//
//  ManifestController.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation
import OSLog

internal class ManifestController {

    // MARK: -
    // MARK: Static Variables

    internal static let logger = Logging.Logger(ManifestController.self)

    // MARK: -
    // MARK: Required Variables

    let category: Manifest.Category
    var manifests = Set<Manifest>()

    // MARK: -
    // MARK: Initialization

    init(category: Manifest.Category) {
        ManifestController.logger.info("Initializing manifest controller for category: \(category.rawValue)")
        self.category = category
        self.updateManifests()
    }

    // MARK: -
    // MARK: Update Manifests

    func updateManifests() {
        ManifestController.logger.info("Updating manifests for controller with category: \(self.category.rawValue))")

        var updatedManifests = Set<Manifest>()
        for directoryRoot in ManifestController.DirectoryRoot.allCases {
            do {
                ManifestController.logger.info("Getting manifests for directory root: \(String(describing: directoryRoot))")

                let directoryURL = try self.directory(forType: .manifests, root: directoryRoot, create: false)
                  try self.addManifests(fromURL: directoryURL, to: &updatedManifests)
            } catch {
                ManifestController.logger.error("Caught exception while updating manifests: \(error)")

                continue
            }
        }

        self.manifests = updatedManifests
    }

    private func addManifests(fromURL url: URL, to manifests: inout Set<Manifest>) throws {
        let manifestURLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        for manifestURL in manifestURLs.filter({ $0.pathExtension == "plist" }) {
            do {
                let manifestData = try Data(contentsOf: manifestURL)
                var manifest = try PropertyListDecoder().decode(Manifest.self, from: manifestData)

                // Verify this manifest is supported by this version of the framework
                guard manifest.formatVersion <= Manifest.formatVersionSupported else {
                    ManifestController.logger.error("Manifest with domain identifier: \(manifest.domainIdentifier) was not included as it's format version was not supported.")
                    ManifestController.logger.error("Manifest format version: \(manifest.formatVersion)")
                    ManifestController.logger.error("Supported format version: \(Manifest.formatVersionSupported)")

                    continue
                }

                // Verify only the latest version of a specific manifest is loaded
                if let existingManifest = manifests.first(where: { $0.domainIdentifier == manifest.domainIdentifier }) {
                    if existingManifest.version < manifest.version || ( existingManifest.version == manifest.version && existingManifest.lastModified < manifest.lastModified ) {
                        manifests.remove(existingManifest)
                    } else {
                        ManifestController.logger.error("A newer version of manifest with domain identifier: \(manifest.domainIdentifier) already exists.")
                        ManifestController.logger.error("Manifest url: \(manifestURL)")
                        ManifestController.logger.error("Existing manifest url: \(existingManifest.manifestURL?.absoluteString ?? "")")
                        continue
                    }
                }

                // Add external information to manifest
                manifest.category = self.category
                manifest.manifestURL = manifestURL
                manifest.iconPath = try ManifestController.directory(forType: .icons, root: .applicationSupport).appending(component: ManifestController.directoryName(forCategory: self.category) ?? "").appending(component: manifest.domainIdentifier)

                // FIXME: Add Override Here

                manifests.insert(manifest)
            } catch {
                ManifestController.logger.error("Error while decoding manifest from url: \(manifestURL)")
                ManifestController.logger.error("Error: \(error)")
                continue
            }
        }
    }
}

// MARK: -
// MARK: Hashable

extension ManifestController: Hashable {
    static func == (lhs: ManifestController, rhs: ManifestController) -> Bool {
        return lhs.category == rhs.category
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(category)
    }
}
