//
//  Regex.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 28/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class Regex {

    static func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    static func getKey(of string: String) -> String? {
        return matches(for: "\".+?\"", in: string).first
    }

    static func getKeyNotCleaned(of string: String) -> String? {
        return matches(for: "\".+?\" *: *", in: string).first
    }

    static func getValue(of string: String) -> String? {
        return matches(for: ": *\\[((.|\n)*)\\],?|: *\\{((.|\n)*)\\},?|: .+", in: string).first
    }

    static func getInnerObject(of string: String) -> String? {
        return matches(for: "\\{((.|\n)*)\\},?", in: string).first?.cleanObject()
    }

    static func getInnerArray(of string: String) -> String? {
        return matches(for: "\\[((.|\n)*)\\],?", in: string).first?.cleanObject()
    }

    static func getElements(of string: String) -> [String]? {
        return matches(for: "\".+\" *:.+,?", in: string)
    }

    static func getObjects(of string: String) -> [String]? {
        return matches(for: "\".+\" *: *\\{((.|\n)*?)\\},?", in: string)
    }

    static func getArrayObjects(of string: String) -> [String]? {
        return matches(for: "\".+\" *: *\\[((.|\n)*?)\\],?", in: string)
    }
    // First clean ArrayObjects, Objects and Elements
    static func getAllElements(of string: String) -> [String]? {
        var res: [String] = [String]()
        var cleanedString = string
        let arrayObjects = getArrayObjects(of: cleanedString)
        if let arrayObjects = arrayObjects{
            res.append(contentsOf: arrayObjects)
        }
        arrayObjects?.forEach {
            cleanedString = cleanedString.replacingOccurrences(of: $0, with: "")
        }
        let objects = getObjects(of: cleanedString)
        if let objects = objects {
            res.append(contentsOf: objects)
        }
        objects?.forEach {
            cleanedString = cleanedString.replacingOccurrences(of: $0, with: "")
        }
        let elements = getElements(of: cleanedString)
        if let elements = elements {
            res.append(contentsOf: elements)
        }
        return res

    }

}

