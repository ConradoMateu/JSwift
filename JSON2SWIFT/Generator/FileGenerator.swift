//
//  FileGenerator.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class FileGenerator {
    static func generaterFrom(name: String, text: String, directory: URL) {
        do {
                let fileURL = directory.appendingPathComponent(name.capitalized + ".swift")
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("error:", error)
        }
    }
}
