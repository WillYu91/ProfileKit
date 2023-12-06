//
//  Data.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension Data {

    // Modified version from https://stackoverflow.com/a/26503955
    init?(withHexString hexString: String) {
        guard hexString.count.isMultiple(of: 2) else {
            return nil
        }

        let chars = Array(hexString)
        let bytes = stride(from: 0, to: chars.count, by: 2)
            .map { String(chars[$0]) + String(chars[$0 + 1]) }
            .compactMap { UInt8($0, radix: 16) }

        guard hexString.count / bytes.count == 2 else { return nil }
        self.init(bytes)
    }

    func plist() throws -> [String: Any] {
        var format = PropertyListSerialization.PropertyListFormat.xml
        return try withUnsafeMutablePointer(to: &format) {
            guard let plist = try PropertyListSerialization.propertyList(from: self, options: .mutableContainersAndLeaves, format: $0) as? [String: Any] else {
                // FIXME: Add correct Error
                throw NSError(domain: "example.domain", code: 3, userInfo: nil)
            }
            return plist
        }
    }
}
