//
//  Logging.swift
//  ProfileKit
//
//  Created by Will Yu.
//  Copyright © 2023 Will Yu. All rights reserved.
//

import Foundation
import OSLog

internal final class Logging {
    internal static let subsystem = "com.profilekit.logging"

    internal static func Logger(_ category: Any) -> Logger {
        return os.Logger(subsystem: subsystem, category: String(describing: category))
    }
}
