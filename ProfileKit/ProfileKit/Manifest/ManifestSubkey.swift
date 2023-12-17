//
//  ManifestSubkey.swift
//  ProfileKit
//
//  Created by Will Yu.
//  Copyright © 2023 Will Yu. All rights reserved.
//

import Foundation

public struct ManifestSubkey: Codable {
    // MARK: -
    // MARK: Variables Required
    public var type: String

    // MARK: -
    // MARK: Variables Optional

    public var allowedFileTypes: [String]?
    public var allowCustomValue: Bool? = false
    public var allowPastDates: Bool? = false
    public var appDeprecated: String?
    public var appMax: String?
    public var appMin: String?
    public var conditionals: [[String: Subkey]]?
    public var dateStyle: String?
    public var defaultValue: Subkey?
    public var defaultValueCopyTarget: String?
    public var description: String?
    public var descriptionExtended: String?
    public var descriptionReference: String?
    public var documentationURL: String?
    public var enabled: Bool? = false
    public var exclude: [[String: Subkey]]?
    public var excluded: Bool? = false
    public var format: String?
    public var hidden: Subkey.Hidden? = .no
    public var importProcessor: String?
    public var infoProcessor: String?
    public var iOSDeprecated: String?
    public var iOSMax: String?
    public var iOSMin: String?
    public var macOSDeprecated: String?
    public var macOSMax: String?
    public var macOSMin: String?
    public var name: String?
    public var note: String?
    public var placeholderValue: Subkey?
    public var platforms: [String]?
    public var platformsNotSupported: [String]?
    public var rangeList: [Subkey]?
    public var rangeListTitles: [String]?
    public var rangeMax: Subkey?
    public var rangeMin: Subkey?
    public var require: Subkey.Require? = .optional
    public var required: Bool? = false
    public var requireSupervision: Bool? = false
    public var requireUserApprovedMDM: Bool? = false
    public var repetitionMax: Int?
    public var repetitionMin: Int?
    public var segments: [String: [String]]?
    public var sensitive: Bool? = false
    public var subkeys: [ManifestSubkey]? = [ManifestSubkey]()
    public var substitutionVariables: [String: [String: String]]?
    public var targets: [String]?
    public var title: String?
    public var tvOSDeprecated: String?
    public var tvOSMax: String?
    public var tvOSMin: String?
    public var typeInput: String?
    public var valueCopyTarget: String?
    public var valueDecimalPlaces: Int?
    public var valueInverted: Bool? = false
    public var valueProcessor: String?
    public var valueUnique: Bool? = false
    public var valueUnit: String?
    public var view: String?
}

/// Extension for leveraging compiler generated Codable protocol implementation to map the actual plist keys to our model representation.
extension ManifestSubkey {
    enum CodingKeys: String, CodingKey {
        case allowedFileTypes = "pfm_allowed_file_types"
        case allowPastDates = "pfm_date_allow_past"
        case allowCustomValue = "pfm_range_list_allow_custom_value"
        case appDeprecated = "pfm_app_deprecated"
        case appMax = "pfm_app_max"
        case appMin = "pfm_app_min"
        case conditionals = "pfm_conditionals"
        case dateStyle = "pfm_date_style"
        case defaultValue = "pfm_default"
        case defaultValueCopyTarget = "pfm_default_copy"
        case description = "pfm_description"
        case descriptionExtended = "pfm_description_extended"
        case descriptionReference = "pfm_description_reference"
        case documentationURL = "pfm_documentation_url"
        case enabled = "pfm_enabled"
        case exclude = "pfm_exclude"
        case excluded = "pfm_excluded"
        case format = "pfm_format"
        case hidden = "pfm_hidden"
        case importProcessor = "pfm_value_import_processor"
        case infoProcessor = "pfm_value_info_processor"
        case iOSDeprecated = "pfm_ios_deprecated"
        case iOSMax = "pfm_ios_max"
        case iOSMin = "pfm_ios_min"
        case macOSDeprecated = "pfm_macos_deprecated"
        case macOSMax = "pfm_macos_max"
        case macOSMin = "pfm_macos_min"
        case name = "pfm_name"
        case note = "pfm_note"
        case placeholderValue = "pfm_value_placeholder"
        case platforms = "pfm_platforms"
        case platformsNotSupported = "pfm_n_platforms"
        case repetitionMax = "pfm_repetition_max"
        case repetitionMin = "pfm_repetition_min"
        case require = "pfm_require"
        case required = "pfm_required"
        case requireSupervision = "pfm_supervised"
        case requireUserApprovedMDM = "pfm_user_approved"
        case rangeList = "pfm_range_list"
        case rangeListTitles = "pfm_range_list_titles"
        case rangeMax = "pfm_range_max"
        case rangeMin = "pfm_range_min"
        case segments = "pfm_segments"
        case sensitive = "pfm_sensitive"
        case subkeys = "pfm_subkeys"
        case substitutionVariables = "pfm_substitution_variables"
        case targets = "pfm_targets"
        case title = "pfm_title"
        case tvOSDeprecated = "pfm_tvos_deprecated"
        case tvOSMax = "pfm_tvos_max"
        case tvOSMin = "pfm_tvos_min"
        case type = "pfm_type"
        case typeInput = "pfm_type_input"
        case valueCopyTarget = "pfm_value_copy"
        case valueDecimalPlaces = "pfm_value_decimal_places"
        case valueInverted = "pfm_value_inverted"
        case valueProcessor = "pfm_value_processor"
        case valueUnique = "pfm_value_unique"
        case valueUnit = "pfm_value_unit"
        case view = "pfm_view"
    }
}
