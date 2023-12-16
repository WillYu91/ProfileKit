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

        public init (from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            do {
                let value = try container.decode(String.self)
                
                self = Manifest.Interaction(rawValue: value) ?? .undefined
            } catch {
                self = .undefined
            }
        }
    }
}
