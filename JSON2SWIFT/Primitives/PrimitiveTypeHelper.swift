//
//  PrimitiveTypeHelper.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class PrimitiveTypeHelper {

    static func transform(dict: [String: AnyObject]) -> [String: Any] {
        var res: [String: AnyObject] = [:]
        for (key, _) in dict {
            res[key] = infer(type: dict[key]!.description!) as AnyObject
        }
        return res
    }
    static func infer(type: String) -> Primitives? {
        var typeCleaned = type
        if typeCleaned.last == "," {
            typeCleaned = String(type.dropLast())
        }

        if let array = Regex.getInnerArray(of: typeCleaned){
            return Primitives.array
        } else if let object =  Regex.getInnerObject(of: typeCleaned)?.isEmpty {
            return Primitives.object
        } else if typeCleaned.isBool() {
            return Primitives.bool
        }else if typeCleaned.isNumeric {
            return numericInfer(type: typeCleaned)
        } else {
            return Primitives.string
        }
    }

    static func numericInfer(type: String) -> Primitives {
        if(type.contains(".")) {
            return Primitives.double
        } else { return Primitives.int
    }
}
}
