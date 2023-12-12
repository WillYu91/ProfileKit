//
//  ManifestsError.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

enum ManifestsError: Error {
    case unknown
    case badPath
    case uninitializedCategory(Manifest.Category)
    case uninitializedCategories(Set<Manifest.Category>)
}

extension ManifestsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .badPath:
            return "Bad Path for manifests"
        case .uninitializedCategory(let category):
            return "Category \(category) is not initialized. You must initialize a manifest category before using it."
        case .uninitializedCategories(let categories):
            return "Categories \(categories) are not initialized. You must initialize a manifest category before using it."
        }
    }
}
