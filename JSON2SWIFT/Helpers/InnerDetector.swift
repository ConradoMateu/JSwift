//
//  InnerDetector.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 28/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class InnerDetector {
    static func detectInners(json: String) -> [String] {
        //variable created in order to delete regex when found
        var jsonAux: String = json
        var inners = [String]()
        while Regex.getAllElements(of: jsonAux)!.count > 0 {
            let newInner = Regex.getAllElements(of: jsonAux)!.first
            jsonAux = jsonAux.replacingOccurrences(of: newInner!, with: "")
            inners.append(newInner!)
        }
        return inners
    }
}
