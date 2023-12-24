//
//  Payload.swift
//  ProfileKit
//
//  Created by Will Yu.
//  Copyright © 2023 Will Yu. All rights reserved.
//

import Foundation

public struct Payload: Codable {

    // MARK: -
    // MARK: Variables Static

    public static let commonKeys = [Payload.CodingKeys.payloadDescription.rawValue,
                                    Payload.CodingKeys.payloadDisplayName.rawValue,
                                    Payload.CodingKeys.payloadIdentifier.rawValue,
                                    Payload.CodingKeys.payloadType.rawValue,
                                    Payload.CodingKeys.payloadUUID.rawValue,
                                    Payload.CodingKeys.payloadVersion.rawValue,
                                    Payload.CodingKeys.payloadOrganization.rawValue]

    // MARK: -
    // MARK: Variables Required

    public var payloadIdentifier: String
    public var payloadUUID: String
    public var payloadVersion: Int

    // MARK: -
    // MARK: Variables Optional

    public var payloadContent: Subkey?
    public var payloadDescription: String?
    public var payloadDisplayName: String?
    public var payloadOrganization: String?
    public var payloadType: String?
}

extension Payload {
    enum CodingKeys: String, CodingKey {
        case payloadContent = "PayloadContent"
        case payloadDescription = "PayloadDescription"
        case payloadDisplayName = "PayloadDisplayName"
        case payloadIdentifier = "PayloadIdentifier"
        case payloadOrganization = "PayloadOrganization"
        case payloadType = "PayloadType"
        case payloadUUID = "PayloadUUID"
        case payloadVersion = "PayloadVersion"
    }
}

// MARK: -
// MARK: Hashable

extension Payload: Hashable {
    public static func == (lhs: Payload, rhs: Payload) -> Bool {
        return lhs.payloadIdentifier == rhs.payloadIdentifier && lhs.payloadUUID == rhs.payloadUUID
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(payloadIdentifier)
        hasher.combine(payloadUUID)
    }
}
