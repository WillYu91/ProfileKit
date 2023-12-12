//
//  Subkey+Hidden.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension Subkey {
    enum Hidden: String, Codable {
        case no
        case all
        case container

        init(keyValue: String) {
            self = Subkey.Hidden(rawValue: keyValue) ?? .no
        }
    }
}
