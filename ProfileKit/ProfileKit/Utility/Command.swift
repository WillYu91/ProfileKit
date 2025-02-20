//
//  Command.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class Command {

    private static let logger = Logging.Logger(Command.self)

    public static func run(path: String, arguments: [String]?) async throws -> Data {
        return try await Task {
            let task = Process()
            let stdOutPipe = Pipe()

            task.launchPath = path
            task.arguments = arguments
            task.standardOutput = stdOutPipe

            try task.run()

            return stdOutPipe.fileHandleForReading.readDataToEndOfFile()
        }.value
    }

    public static func plistFromOutputStringData(_ data: Data) throws -> [String: Any]? {
        guard let string = String(data: data, encoding: .utf8) else {
            Command.logger.error("Failed to get string from command output")
            return nil
        }

        let plistScanner = Scanner(string: string)

        // Move to the first line containing '<?xml'
        _ = plistScanner.scanUpToString("<?xml")

        guard let plistScannerString = plistScanner.scanUpToString("</plist>") else {
            return nil
        }

        // If the scannerString is not empty, replace the plistString
        guard let plistData = (plistScannerString + "\n</plist>").data(using: .utf8) else {
            return nil
        }

        // Convert the output to a dictionary
        guard let plist = try PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: Any] else {
            Command.logger.error("Failed to decode plist string \(plistScannerString))")
            return nil
        }

        return plist
    }
}
