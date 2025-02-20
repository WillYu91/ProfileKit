//
//  Manifest+Category.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension Manifest {
    enum Category: String, Codable {
        case unknown
        case applePayload
        case applePreference
        case applicationPreference
        case developerPreference
        case preference
        case custom

        init(keyValue: String) {
            self = Manifest.Category(rawValue: keyValue) ?? .unknown
        }
    }
}
