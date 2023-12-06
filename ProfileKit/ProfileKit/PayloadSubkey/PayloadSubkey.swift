//
//  PayloadSubkey.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class PayloadSubkey {

    // MARK: -
    // MARK: Variables Static

    // MARK: -
    // MARK: Variables Required

    public var key: String
    public var type: String

    // MARK: -
    // MARK: Variables Optional

    public var enabled = false
    public var defaultValue: Any?
    public var subkeys: [PayloadSubkey]?
    public var value: Any?
    public var valueUnit: String?
    public var view: String?

    // MARK: -
    // MARK: Initialization

    init(key: String, type: String) {
        self.key = key
        self.type = type
    }
}
