//
//  ManifestController+Directory.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension ManifestController {

    enum DirectoryRoot: CaseIterable {
        case applicationSupport
        case custom
        case bundle
    }

    enum DirectoryType: String, CaseIterable {
        case manifests = "Manifests"
        case manifestOverrides = "ManifestOverrides"
        case icons = "Icons"
        case iconOverrides = "IconOverrides"
    }

    func directory(forType type: ManifestController.DirectoryType, root: ManifestController.DirectoryRoot, create: Bool) throws -> URL {
        guard let directoryName = ManifestController.directoryName(forCategory: self.category) else { throw ManifestsError.badPath }
        let typeURL = try ManifestController.directory(forType: type, root: root)
        let directoryURL = typeURL.appendingPathComponent(directoryName, isDirectory: true)
        if create {
            try FileManager.default.createDirectoryIfNotExists(at: directoryURL, withIntermediateDirectories: true)
        }
        return directoryURL
    }

    static func directory(forType type: ManifestController.DirectoryType, root: ManifestController.DirectoryRoot) throws -> URL {
        do {
            let rootURL = try ManifestController.directory(forRoot: root)
            return rootURL.appendingPathComponent(type.rawValue, isDirectory: true)
        } catch {
            ManifestController.logger.error("Failed to get root URL for \(String(describing: root))")

            throw error
        }
    }

    static func directory(forRoot root: ManifestController.DirectoryRoot) throws -> URL {
        switch root {
        case .applicationSupport:

            var domain = FileManager.SearchPathDomainMask.localDomainMask

            if getuid() != 0 {
                domain = FileManager.SearchPathDomainMask.userDomainMask
            }

            let applicationSupportURL = try FileManager.default.url(for: .applicationSupportDirectory,
                                                                    in: domain,
                                                                    appropriateFor: nil,
                                                                    create: false)
            return applicationSupportURL.appendingPathComponent("ProfilePayloads", isDirectory: true)
        case .bundle:
            return Bundle(for: Manifests.self).bundleURL.appendingPathComponent("Resources", isDirectory: true)
        case .custom:
            if let customPath = UserDefaults.standard.string(forKey: PreferenceKey.manifestDirectoryRootPath) {
                return URL(fileURLWithPath: customPath)
            }
        }

        throw ManifestsError.badPath
    }

    static public func directoryName(forCategory category: Manifest.Category) -> String? {
        switch category {
        case .applePayload:
            return "ManifestsApple"
        case .applePreference:
            return "ManagedPreferencesApple"
        case .applicationPreference:
            return "ManagedPreferencesApplications"
        case .developerPreference:
            return "ManagedPreferencesDeveloper"
        case .preference:
            return "Preferences"
        case .custom:
            return ""
        case .unknown:
            return nil
        }
    }
}
