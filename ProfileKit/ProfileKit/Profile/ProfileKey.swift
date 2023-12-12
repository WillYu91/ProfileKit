//
//  ProfileKey.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

/// Top level keys for profiles are
///  defined here https://developer.apple.com/documentation/devicemanagement/toplevel
public enum ProfileKey: String, CodingKey, CaseIterable {

    /**
     Optional. A dictionary containing these keys and values:
     • Foreachlanguageinwhichaconsentorlicense
     agreement is available, a key consisting of the IETF BCP 47 identifier for that language (for example, en or jp) and a value consisting of the agreement localized to that language. The agreement is displayed in a dialog to which the user must agree before installing the profile.
     • Theoptionalkeydefaultwithitsvalueconsistingofthe unlocalized agreement (usually in en).
     The system chooses a localized version in the order of preference specified by the user (macOS) or based on the userʼs current language setting (iOS). If no exact match is found, the default localization is used. If there is no default localization, the en localization is used. If there is no en localization, then the first available localization is used.
     You should provide a default value if possible. No warning will be displayed if the userʼs locale does not match any localization in the ConsentText dictionary.
     */
    case consentText = "ConsentText"

    /**
     Optional. Number of seconds until the profile is automatically removed.

     If the RemovalDate keys is present, whichever field yields the earliest date will be used.
     */
    case durationUntilRemoval = "DurationUntilRemoval"

    /**
     Enabled if IsEncrypted is true.
     */
    case encryptedPayloadContent = "EncryptedPayloadContent"

    /**
     Set to true if there’s a removal passcode.
     */
    case hasRemovalPasscode = "HasRemovalPasscode"

    /**
     Set to true if the profile is encrypted.
     */
    case isEncrypted = "IsEncrypted"

    /**
     (Required). Array of payload dictionaries. Not present if IsEncrypted is true.
     */
    case payloadContent = "PayloadContent"

    /**
     Optional. A description of the profile, shown on the Detail screen for the profile.

     This should be descriptive enough to help the user decide whether to install the profile.
     */
    case payloadDescription = "PayloadDescription"

    /**
     Optional. A human-readable name for the profile.

     This value is displayed on the Detail screen. It does not have to be unique.
     */
    case payloadDisplayName = "PayloadDisplayName"

    /**
     Optional. A date on which a profile is considered to have expired and can be updated over the air.

     This key is only used if the profile is delivered via over-the-air profile delivery.
     */
    case payloadExpirationDate = "PayloadExpirationDate"

    /**
     A reverse-DNS style identifier (com.example.myprofile, for example) that identifies the profile.

     This string is used to determine whether a new profile should replace an existing one or should be added.
     */
    case payloadIdentifier = "PayloadIdentifier"

    /**
     Optional. A human-readable string containing the name of the organization that provided the profile.
     */
    case payloadOrganization = "PayloadOrganization"

    /**
     Optional. Supervised only. If present and set to true, the user cannot delete the profile (unless the profile has a removal password and the user provides it).
     */
    case payloadRemovalDisallowed = "PayloadRemovalDisallowed"

    /**
     Optional. Determines if the profile should be installed for the system or the user.

     In many cases, it determines the location of the certificate items, such as keychains. Though it is not possible to declare different payload scopes, payloads, like VPN, may automatically install their items in both scopes if needed.

     Legal values are System and User, with User as the default value.

     - Requires: Available in macOS 10.7 and later.
     */
    case payloadScope = "PayloadScope"

    /**
     The only supported value is Configuration.
     */
    case payloadType = "PayloadType"

    /**
     A globally unique identifier for the profile.

     The actual content is unimportant, but it must be globally unique. In macOS, you can use uuidgen to generate reasonable UUIDs.
     */
    case payloadUUID = "PayloadUUID"

    /**
     The version number of the profile format.

     This describes the version of the configuration profile as a whole, not of the individual profiles within it.
     Currently, this value should be 1.
     */
    case payloadVersion = "PayloadVersion"

    /**
     Optional. The date on which the profile will be automatically removed.
     */
    case removalDate = "RemovalDate"

    /**
     The type of platform of the target device. Specifying the platform type helps prevent unintended installations.
     */
    case targetDeviceType = "TargetDeviceType"
}

// MARK: -
// MARK: Extension - ProfileKeyProtocol

extension ProfileKey: ProfileKeyProtocol {
    public var valueType: Dictionary<String, Any>.ValueType {
        switch self {
        case .consentText:              return .string
        case .durationUntilRemoval:     return .integer
        case .encryptedPayloadContent:  return .data
        case .hasRemovalPasscode:       return .bool
        case .isEncrypted:              return .bool
        case .payloadContent:           return .any
        case .payloadDescription:       return .string
        case .payloadDisplayName:       return .string
        case .payloadExpirationDate:    return .date
        case .payloadIdentifier:        return .string
        case .payloadOrganization:      return .string
        case .payloadRemovalDisallowed: return .bool
        case .payloadScope:             return .string
        case .payloadType:              return .string
        case .payloadUUID:              return .string
        case .payloadVersion:           return .integer
        case .removalDate:              return .date
        case .targetDeviceType:         return .integer
        }
    }

    public var rawValues: [RawValue] {
        switch self {

        // All that doesn't have multiple values, just return rawValue
        default:                        return [self.rawValue]
        }
    }
}
