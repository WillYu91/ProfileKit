//
//  ManifestSubkey+Require.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension ManifestSubkey {
    enum Require: String, Codable {
        case always
        case alwaysNested = "always-nested"
        case push
        case optional

        init(keyValue: String) {
            self = ManifestSubkey.Require(rawValue: keyValue) ?? .optional
        }
    }
}
