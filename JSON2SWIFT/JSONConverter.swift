//
//  JSONConverter.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 03/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation
class JSONConverter {
    func convertJSONFrom(dict: [String: String]) -> String {
        var res = """
{\n
"""
        dict.forEach {
            if PrimitiveTypeHelper.infer(type: $1 ) == .object {
                res.append(buildInnerDictFrom(key: $0, value: $1))
            } else {
                res.append("\($0): \($1),\n")
            }
        }
        res.append("}")
        return res
}
    func buildInnerDictFrom(key: String, value: String) -> String {
        var res = """
\(key): {\n
"""
        var line = value.components(separatedBy: "\n").dropLast()
        let last = line.last
        line = line.dropLast()
        line.forEach {
            let string = $0 as String
            var element = string.components(separatedBy: ": ")
            res.append("\(element[0]): \(element[1].cleanValue()),\n")
        }
        let string = last as! String
        var element = string.components(separatedBy: ": ")
        res.append("\(element[0]): \(element[1].cleanValue())\n")
        res.append("},\n")
        return res
    }
    }
