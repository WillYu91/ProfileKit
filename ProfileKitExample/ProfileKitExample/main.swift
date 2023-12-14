//
//  main.swift
//  ProfileKitExample
//
//  Created by Erik Berglund on 2019-05-01.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation
import ProfileKit
import Cocoa

do {

    let installedProfiles = try await InstalledProfiles.querySystemForAllProfiles()
    Swift.print("Installed Profiles: \(String(describing: installedProfiles))")

    let configuURL = URL(fileURLWithPath: "/Users/willyu/Desktop/SCEP.mobileconfig")

    let configuData = try Data(contentsOf: configuURL)

    let conig = try PropertyListDecoder().decode(Profile.self, from: configuData)

    if let payload = conig.payloadContent.first {
        Swift.print("Paload: \(String(describing: payload.payloadContent))")
    }
    
    let categories = Set([Manifest.Category.applePayload])
    try await Manifests.shared.loadManifestsFromDisk(categories: categories)
    
    let manifests = try Manifests.shared.manifests(forCategory: .applePayload)
    for manifest in manifests {
        Swift.print("manifest.domainIdentifier: \(manifest.domainIdentifier)")
        Swift.print("manifest.interaction: \(manifest.interaction)")
        Swift.print("manifest.title: \(manifest.title)")
        Swift.print("manifest.manifestURL: \(String(describing: manifest.manifestURL))")

        for subkey in manifest.subkeys {
            Swift.print("subkey name: \(subkey.name), subkey type: \(subkey.type)")
        }
    }
} catch {
    Swift.print("error: \(error)")
}

