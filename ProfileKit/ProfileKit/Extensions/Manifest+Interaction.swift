//
//  Manifest+Interaction.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension Manifest {
    enum Interaction: String, Codable {
        case undefined
        case combined
        case exclusive

        init(keyValue: String) {
            self = Manifest.Interaction(rawValue: keyValue) ?? .undefined
        }
    }
}
