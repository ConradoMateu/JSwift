//
//  FileGenerator.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class FileGenerator {
    static func generaterFrom(dict: [String: Any], name: String, directory: URL) {
        do {
            // get the documents folder url

                // create the destination url for the text file to be saved
                let fileURL = directory.appendingPathComponent(name.capitalized + ".swift")
                // define the string/text to be saved
                let text = correctFormatFrom(dict: dict)
                // writing to disk

                let completeText = """
struct \(name): Codable {
\(text)
\(getCodingKeys(dict: dict))
}
"""


                try completeText.write(to: fileURL, atomically: false, encoding: .utf8)

                print("saving was successful")
                // any code posterior code goes here
                // reading from disk
                let savedText = try String(contentsOf: fileURL)
                print("savedText:", savedText)   // "Hello World !!!\n"

        } catch {
            print("error:", error)
        }
    }

    static func correctFormatFrom(dict: [String: Any]) -> String {
        var res = ""
        dict.forEach {
            let primitive = $1 as? Primitives
            if primitive == .object {
                let value = "\tlet \($0.cleaned): \($0.cleaned.capitalized)?\n"
                res.append(value)
            } else if  primitive == .array{
                let value = "\tlet \($0.cleaned): [\($0.cleaned.capitalized)]?\n"
                res.append(value)
            }else {
                res.append("\tlet \($0.cleaned): \(($1 as! Primitives).rawValue.cleaned.capitalized)?\n")
            }

        }
        return res
    }

    static func getCodingKeys(dict:[String:Any]) -> String{
        var res = """
\tenum CodingKeys: String, CodingKey {\n
"""
        dict.forEach {
            res.append("\t\tcase \($0.key.cleaned)\n")
        }
        res.append("\t}\n")
        return res
    }
}
