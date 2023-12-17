//
//  Subkey+Require.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension Subkey {
    enum Require: String, Codable {
        case always
        case alwaysNested = "always-nested"
        case push
        case optional

        init(keyValue: String) {
            self = Subkey.Require(rawValue: keyValue) ?? .optional
        }
    }
}
