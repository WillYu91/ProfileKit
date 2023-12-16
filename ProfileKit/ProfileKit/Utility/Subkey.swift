//
//  Subkey.swift
//  ProfileKit
//
//  Created by Will Yu.
//  Copyright © 2023 Will Yu. All rights reserved.
//

import Foundation

public enum Subkey: Codable {

    case array([Subkey])
    case bool(Bool)
    case date(Date)
    case data(Data)
    case dictionary([String: Subkey])
    case double(Double)
    case float(Float)
    case integer(Int)
    case string(String)

    enum SubkeyError: Error {
        case missingValue
    }

    public init (from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let array = try? container.decode([Subkey].self) {
            self = .array(array)
            return
        }

        if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
            return
        }

        if let date = try? container.decode(Date.self) {
            self = .date(date)
            return
        }

        if let data = try? container.decode(Data.self) {
            self = .data(data)
            return
        }

        if let dictionary = try? container.decode([String: Subkey].self) {
            self = .dictionary(dictionary)
            return
        }

        if let double = try? container.decode(Double.self){
            self = .double(double)
            return
        }
        
        if let float = try? container.decode(Float.self) {
            self = .float(float)
            return
        }

        if let integer = try? container.decode(Int.self) {
            self = .integer(integer)
            return
        }

        if let string = try? container.decode(String.self) {
            self = .string(string)
            return
        }

        throw SubkeyError.missingValue
    }
    
    public var value: Any? {
        switch self {
        case .array(let array):
            return array
        case .bool(let bool):
            return bool
        case .data(let data):
            return data
        case .date(let date):
            return date
        case .dictionary(let dictionary):
            return dictionary
        case .double(let double):
            return double
        case .float(let float):
            return float
        case .integer(let integer):
            return integer
        case .string(let string):
            return string
        }

        return nil
    }
}
