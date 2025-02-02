//
//  Manifest.swift
//  ProfileKit
//
//  Created by Will Yu.
//  Copyright © 2023 Will Yu. All rights reserved.
//

import Foundation

public struct Manifest: Codable {

    static public let formatVersionSupported = 5

    // MARK: -
    // MARK: Variables Required

    public var description: String
    public var domain: String
    public var formatVersion: Int
    public var lastModified: Date
    public var platforms: [String]
    public var title: String
    public var version: Int

    // MARK: -
    // MARK: Variables Optional

    public var appURL: String?
    public var descriptionReference: String?
    public var documentationURL: String?
    public var icon: Data?
    public var iOSDeprecated: String?
    public var iOSMax: String?
    public var iOSMin: String?
    public var interaction: Manifest.Interaction? = Manifest.Interaction.undefined
    public var macOSDeprecated: String?
    public var macOSMax: String?
    public var macOSMin: String?
    public var note: String?
    public var override: String?
    public var requireSupervision: Bool? = false
    public var requireUserApprovedMDM: Bool? = false
    public var subdomain: String?
    public var substitutionVariables: [String: [String: String]]?
    public var subkeys: [ManifestSubkey] = [ManifestSubkey]()
    public var targets: [String]?
    public var tvOSDeprecated: String?
    public var tvOSMax: String?
    public var tvOSMin: String?
    public var unique: Bool? = false

    // MARK: -
    // MARK: Variables Externally Set

    public var manifestURL: URL?
    public var category: Category?
    public var iconPath: URL?

    // MARK: -
    // MARK: Cached Computed Variables

    private class CachedMetadata {
        var subKeysPayloadContent: [ManifestSubkey]?
        var domainIdentifier: String?
    }

    private var cachedMetadata = CachedMetadata()

    public var domainIdentifier: String {

        if let domainIdentifier = cachedMetadata.domainIdentifier {
            return domainIdentifier
        }

        guard let subdomain = self.subdomain else {
            self.cachedMetadata.domainIdentifier = self.domain

            return self.cachedMetadata.domainIdentifier!
        }

        self.cachedMetadata.domainIdentifier = subdomain + "-" + self.domain

        return self.cachedMetadata.domainIdentifier!
    }

    public var subKeysPayloadContent: [ManifestSubkey] {

        if let subKeysPayloadContent = cachedMetadata.subKeysPayloadContent {
            return subKeysPayloadContent
        }

        cachedMetadata.subKeysPayloadContent = self.subkeys.filter({ !Payload.commonKeys.contains($0.name ?? "") })

        return cachedMetadata.subKeysPayloadContent!
    }
}

extension Manifest {
    enum CodingKeys: String, CodingKey {
        case appURL = "pfm_app_url"
        case description = "pfm_description"
        case descriptionReference = "pfm_description_reference"
        case documentationURL = "pfm_documentation_url"
        case domain = "pfm_domain"
        case formatVersion = "pfm_format_version"
        case icon = "pfm_icon"
        case interaction = "pfm_interaction"
        case iOSDeprecated = "pfm_ios_deprecated"
        case iOSMax = "pfm_ios_max"
        case iOSMin = "pfm_ios_min"
        case lastModified = "pfm_last_modified"
        case macOSDeprecated = "pfm_macos_deprecated"
        case macOSMax = "pfm_macos_max"
        case macOSMin = "pfm_macos_min"
        case note = "pfm_note"
        case platforms = "pfm_platforms"
        case requireSupervision = "pfm_supervised"
        case requireUserApprovedMDM = "pfm_user_approved"
        case subdomain = "pfm_subdomain"
        case subkeys = "pfm_subkeys"
        case substitutionVariables = "pfm_substitution_variables"
        case targets = "pfm_targets"
        case title = "pfm_title"
        case tvOSDeprecated = "pfm_tvos_deprecated"
        case tvOSMax = "pfm_tvos_max"
        case tvOSMin = "pfm_tvos_min"
        case unique = "pfm_unique"
        case version = "pfm_version"
        
        // Dynamically set values
        case iconPath
        case manifestURL
        case category
    }
}

// MARK: -
// MARK: Hashable

extension Manifest: Hashable {
    public static func == (lhs: Manifest, rhs: Manifest) -> Bool {
        return lhs.subdomain == rhs.subdomain && lhs.domain == rhs.domain
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(subdomain)
        hasher.combine(domain)
    }
}

// MARK: -
// MARK: Identifiable

extension Manifest: Identifiable {
    public var id: String {
        domainIdentifier
    }
}

// MARK: -
// MARK: Comparable

extension Manifest: Comparable {
    public static func < (lhs: Manifest, rhs: Manifest) -> Bool {
        lhs.domainIdentifier < rhs.domainIdentifier
    }
}

