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
        if res.last == " " {
            res = String(res.dropLast())
        }
        if res.last == "," {
            res = String(res.dropLast())
        }
                return res
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

