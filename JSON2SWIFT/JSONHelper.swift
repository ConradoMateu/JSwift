//
//  JSONHelper.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation


class JSONHelper{
    // Input --> { "name": Conrado, "surname": Mateu Gisbert}
    // line = "name": Conrado
    // Output --> dict["name"] = Conrado
    static func generateDictFrom(JSON: String) -> [String:Any]{
        var dict: [String:Any] = [:]
        let line = JSON.components(separatedBy: "\n")
        let newLines = line.filter{!$0.cleaned.isEmpty  && !($0 == "{") && !($0 == "}")}
        newLines.forEach{
            let element = $0.components(separatedBy: ": ")
            let key = element[0].cleaned
            let value = element[1].dropLast()
            dict[key] = value
        }
        
        return dict
    }

    static func generateDictFrom(String: String) -> [String:Any]{
        var dict: [String:Any] = [:]
        let lines = String.components(separatedBy: "\n")
        lines.forEach{
            var element = $0.components(separatedBy: ": ")
            let key = element[0].cleaned
            let value = element[1].cleanValue()
            dict[key] = value
        }

        return dict
    }
}
