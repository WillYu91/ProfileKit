//
//  Manifests.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class Manifests {

    // MARK: -
    // MARK: Static Variables

    public static let shared = Manifests()

    private static let logger = Logging.Logger(Manifests.self)

    // MARK: -
    // MARK: Required Variables

    /**
     Manifest categories currently initialized.
     */
    public var categories: Set<Manifest.Category> { return Set(self.manifestControllers.compactMap { $0.category }) }

    /**
     Manifest controllers currently initialized.
     */
    private var manifestControllers = Set<ManifestController>()

    // MARK: -
    // MARK: Initialization

    private init() {}

    public func loadManifestsFromDisk(categories: Set<Manifest.Category>) async throws {
        for category in categories.subtracting(self.categories) {
            self.manifestControllers.insert(ManifestController(category: category))
        }
    }

    // MARK: -
    // MARK: Updating Manifests

    /**
     Updates all initialized manifest categories.
     */
    public func updateManifests() throws {
        try self.updateManifests(categories: self.categories)
    }

    /**
     Updates the specified manifest category.
     */
    public func updateManifest(category: Manifest.Category) throws {
        try self.updateManifests(categories: [category])
    }

    /**
     Updates the specified manifest categories.
     */
    public func updateManifests(categories: Set<Manifest.Category>) throws {
        guard self.categories.isSuperset(of: categories) else {
            throw ManifestsError.uninitializedCategories(categories)
        }

        self.manifestControllers.filter({ categories.contains($0.category) }).forEach { manifestController in
            manifestController.updateManifests()
        }
    }

    // MARK: -
    // MARK: Get Single Manifests

    public func manifest(forDomainIdentifier domainIdentifier: String, category: Manifest.Category) throws -> Manifest? {
        return try self.manifests(forCategory: category).first { $0.domainIdentifier == domainIdentifier }
    }

    // MARK: -
    // MARK: Get Multiple Manifests

    public func manifests(forCategory category: Manifest.Category) throws -> Set<Manifest> {
        Manifests.logger.info("Getting manifests with category: \(String(describing: category))")
        guard
            self.categories.contains(category),
            let manifestController = self.manifestControllers.first(where: { $0.category == category }) else {
                throw ManifestsError.uninitializedCategory(category)
        }
        return manifestController.manifests
    }

    public func manifests(forDomain domain: String, category: Manifest.Category) throws -> Set<Manifest> {
        Manifests.logger.info("Getting manifests for domain: \(domain.description) with category: \(category.rawValue)")
        return try self.manifests(forCategory: category).filter { $0.domain == domain }
    }

    public func manifests(forDomainIdentifier domainIdentifier: String, category: Manifest.Category) throws -> Set<Manifest> {
        Manifests.logger.info("Getting manifests for domainIdentifier: \(domainIdentifier) with category: \(category.rawValue)")
        return try self.manifests(forCategory: category).filter { $0.domainIdentifier == domainIdentifier }
    }
}
