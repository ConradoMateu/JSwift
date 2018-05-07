//
//  SwiftGenerator.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 12/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class SwiftGenerator {
    static func generaterFrom(dict: [String: Any], name: String) -> String {
        let completeText = """
        struct \(name): Codable {
        \(getVariablesFrom(dict: dict))
        \(getCodingKeys(dict: dict))
        }\n
        """
        return completeText
    }

    private static func getVariablesFrom(dict: [String: Any]) -> String {
        var res = ""
        dict.forEach {
            let primitive = $1 as? Primitives
            if primitive == .object {
                let value = "\tlet \($0.cleaned): \($0.cleaned.capitalized)?\n"
                res.append(value)
            } else if  primitive == .array {
                let value = "\tlet \($0.cleaned): [\($0.cleaned.capitalized)]?\n"
                res.append(value)
            } else {
                res.append("\tlet \($0.cleaned): \(($1 as! Primitives).rawValue.cleaned.capitalized)?\n")
            }

        }
        return res
    }

    private static func getCodingKeys(dict: [String: Any]) -> String {
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
