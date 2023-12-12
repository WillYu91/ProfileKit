//
//  InstalledProfiles.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public struct InstalledProfiles {
    public static func querySystemForAllProfiles() async throws -> [String: [InstalledProfile]] {
        var allProfiles = [String: [InstalledProfile]]()

        let profilesOutput = try await ProfilesCommand.show()

        for scope in [Scope.system.rawValue, Scope.user.rawValue] {
            var scopeProfiles = [InstalledProfile]()

            // Get all profiles for scope.
            guard let profilesScopeProfiles = profilesOutput[scope] else {
                continue
            }

            // Loop through all profiles
            for profile in profilesScopeProfiles {
                do {
                    let profileData = try PropertyListSerialization.data(fromPropertyList: profile, format: .xml, options: 0)
                    let installedProfile = try PropertyListDecoder().decode(InstalledProfile.self, from: profileData)

                    scopeProfiles.append(installedProfile)
                } catch {

                    // FIXME: Proper Logging
                    Swift.print("Unable to create object for \(profile), error: \(error.localizedDescription)")
                    continue
                }
            }

            allProfiles[scope] = scopeProfiles
        }

        return allProfiles
    }
}
