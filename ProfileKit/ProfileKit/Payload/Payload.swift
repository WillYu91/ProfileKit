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

    public static let commonKeys = [PayloadKey.payloadDescription.rawValue,
                                    PayloadKey.payloadDisplayName.rawValue,
                                    PayloadKey.payloadIdentifier.rawValue,
                                    PayloadKey.payloadType.rawValue,
                                    PayloadKey.payloadUUID.rawValue,
                                    PayloadKey.payloadVersion.rawValue,
                                    PayloadKey.payloadOrganization.rawValue]

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
