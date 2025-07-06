//
//  Profile.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public struct Profile: Codable {

    // MARK: -
    // MARK: Variables Constant

    public var payloadType = "Configuration"

    // MARK: -
    // MARK: Variables Required

    public var payloadIdentifier: String
    public var payloadUUID: String
    public var payloadVersion: Int
    public var payloadContent: [Payload]

    // MARK: -
    // MARK: Variables Optional

    public var consentText: [String: String]?
    public var durationUntilRemoval: Int?
    public var encryptedPayloadContent: Data?
    public var hasRemovalPasscode: Bool?
    public var isEncrypted: Bool?
    public var payloadDescription: String?
    public var payloadDisplayName: String?
    public var payloadExpirationDate: Date?
    public var payloadOrganization: String?
    public var payloadRemovalDisallowed: Bool?
    public var payloadScope: String?
    public var removalDate: Date?
    public var targetDeviceType: Int?
}

/// Extension for leveraging compiler generated Codable protocol implementation to map the actual plist keys to our model representation.
extension Profile {
    enum CodingKeys: String, CodingKey {
            case payloadType = "PayloadType"
            case payloadIdentifier = "PayloadIdentifier"
            case payloadUUID = "PayloadUUID"
            case payloadVersion = "PayloadVersion"
            case payloadContent = "PayloadContent"
            case consentText = "ConsentText"
            case durationUntilRemoval = "DurationUntilRemoval"
            case encryptedPayloadContent = "EncryptedPayloadContent"
            case hasRemovalPasscode = "HasRemovalPasscode"
            case isEncrypted = "IsEncrypted"
            case payloadDescription = "PayloadDescription"
            case payloadDisplayName = "PayloadDisplayName"
            case payloadExpirationDate = "PayloadExpirationDate"
            case payloadOrganization = "PayloadOrganization"
            case payloadRemovalDisallowed = "PayloadRemovalDisallowed"
            case payloadScope = "PayloadScope"
            case removalDate = "RemovalDate"
            case targetDeviceType = "TargetDeviceType"
        }
}

// MARK: -
// MARK: Hashable

extension Profile: Hashable {
    public static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.payloadIdentifier == rhs.payloadIdentifier && lhs.payloadUUID == rhs.payloadUUID
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(payloadIdentifier)
        hasher.combine(payloadUUID)
    }
}

// MARK: -
// MARK: Public Init

public extension Profile {
  /// Full initializer for creating a profile in code.
  init(payloadIdentifier: String,
       payloadUUID: String = UUID().uuidString,
       payloadVersion: Int = 1,
       payloadContent: [Payload] = [])
  {
    self.payloadType        = "Configuration"
    self.payloadIdentifier  = payloadIdentifier
    self.payloadUUID        = payloadUUID
    self.payloadVersion     = payloadVersion
    self.payloadContent     = payloadContent
      
    // all optional properties remain nil
  }
}
