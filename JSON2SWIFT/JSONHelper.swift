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
        let line = JSON.components(separatedBy: ",\n")
        line.forEach{
            let element = $0.components(separatedBy: ": ")
            let key = element[0]
            let value = element[1]
            dict[key] = value
        }
        return dict
    }
}
