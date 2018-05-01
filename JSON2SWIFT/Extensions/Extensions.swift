//
//  Extensions.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self).isSubset(of: nums)
    }

    var cleaned: String {
        return self.replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "\n", with: "")
        .replacingOccurrences(of: ",", with: "")
        .replacingOccurrences(of: " ", with: "")
    }

    var firsLetterCapitalized: String {
        return prefix(1).uppercased() + dropFirst()
    }

    func cleanValue() -> String {
        var res = self.replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "##isArray##", with: "")
        if res.last == " " {
            res = String(res.dropLast())
        }
        if res.last == "," {
            res = String(res.dropLast())
        }
        return res
    }

    func cleanObject() -> String {
        var res = self.replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")
        return res
    }

    func cleanFirstBrace() -> String{
        return self.stringByReplacingLastOccurrenceOfString(target: "}\n", withString: "")
            .stringByReplacingFirstOccurrenceOfString(target: "{\n", withString: "")
    }

    func firstKeyCleaned() -> String{
        return self.stringByReplacingLastOccurrenceOfString(target: ":", withString: "")
        .replacingOccurrences(of: " ", with: "")
    }

    func cleanArrayValue() -> String{
        return self.stringByReplacingFirstOccurrenceOfString(target: ": [", withString: "")
        .stringByReplacingLastOccurrenceOfString(target: "]", withString: "")
    }

    func cleanBrackets() -> String{
        return self.stringByReplacingFirstOccurrenceOfString(target: "[", withString: "")
            .stringByReplacingLastOccurrenceOfString(target: "]", withString: "")
    }

    func cleanBraces() -> String{
        return self.stringByReplacingFirstOccurrenceOfString(target: "{", withString: "")
            .stringByReplacingLastOccurrenceOfString(target: "}", withString: "")
    }

    func cleanObjectValue() -> String {
        return self.stringByReplacingFirstOccurrenceOfString(target: ": {", withString: "")
            .stringByReplacingLastOccurrenceOfString(target: "}", withString: "")
    }


    func stringByReplacingLastOccurrenceOfString(
        target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target, options: [.backwards]) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }

    func stringByReplacingFirstOccurrenceOfString(
        target: String, withString replaceString: String) -> String
    {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }

    func toBool() -> Bool? {
        switch self { 
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    func isBool() -> Bool {
        if let _ = self.toBool() {
            return true
        } else {
            return false
        }
    }

    func isObject() -> Bool {
        return self == Primitives.object.rawValue
    }

}

