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

    static func getInnerObject(of string: String) -> String? {
        return matches(for: "\\{((.|\n)*)\\},?", in: string).first
    }


    static func getInnerArray(of string: String) -> String? {
        return matches(for: "\\(((.|\n)*)\\),?", in: string).first
    }

}

