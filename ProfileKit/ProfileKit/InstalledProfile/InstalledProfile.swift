//
//  InstalledProfile.swift
//  ProfileKit
//
//  Created by Will Yu.
//  Copyright © 2023 Will Yu. All rights reserved.
//

import Foundation

public struct InstalledProfileInternalData: Codable {

    // MARK: -
    // MARK: Variables Optional

    var installDate: Date?
    var installedForUID: Int?
    var installedForUser: String?
    var verificationState: String?
}

extension InstalledProfileInternalData {
    enum CodingKeys: String, CodingKey {
        case installDate = "InstallDate"
        case installedForUID = "InstalledForUID"
        case installedForUser = "InstalledForUser"
        case verificationState = "VerificationState"
    }
}

public struct InstalledProfile: Codable {

    // MARK: -
    // MARK: Variables Required

    var internalData: InstalledProfileInternalData
    var payloadContent: [Payload]
    var payloadIdentifier: String
    var payloadScope: String
    var payloadType: String
    var payloadUUID: String
    var payloadVersion: Int

    // MARK: -
    // MARK: Variables Optional

    var payloadDescription: String?
    var payloadDisplayName: String?
}

extension InstalledProfile {
    enum CodingKeys: String, CodingKey {
        case internalData = "InternalData"
        case payloadContent = "PayloadContent"
        case payloadDescription = "PayloadDescription"
        case payloadDisplayName = "PayloadDisplayName"
        case payloadIdentifier = "PayloadIdentifier"
        case payloadScope = "PayloadScope"
        case payloadType = "PayloadType"
        case payloadUUID = "PayloadUUID"
        case payloadVersion = "PayloadVersion"
    }
}

// MARK: -
// MARK: Hashable

extension InstalledProfile: Hashable {
    public static func == (lhs: InstalledProfile, rhs: InstalledProfile) -> Bool {
        return lhs.payloadIdentifier == rhs.payloadIdentifier && lhs.payloadUUID == rhs.payloadUUID
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(payloadIdentifier)
        hasher.combine(payloadUUID)
    }
}
