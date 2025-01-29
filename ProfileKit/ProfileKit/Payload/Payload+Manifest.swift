//
//  Payload+Manifest.swift
//  ProfileKit
//
//  Created by  Will Yu.
//  Copyright © 2024 Will Yu. All rights reserved.
//
import Foundation

extension Payload {
    init(payloadIdentifier: String, payloadUUID: String, manifest: Manifest) {

        self.payloadIdentifier = payloadIdentifier
        self.payloadUUID = payloadUUID
        self.payloadVersion = 1
    }
}
