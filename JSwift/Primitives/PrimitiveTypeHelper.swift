//
//  PrimitiveTypeHelper.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class PrimitiveTypeHelper {

    static func transform(dict: [String: AnyObject]) -> [String: Primitives] {
        var res: [String: Primitives] = [:]
        for (key, _) in dict {
            res[key] = infer(type: dict[key]!)
        }
        return res
    }
    
    static func infer(type: AnyObject) -> Primitives? {
        if (type as? [[String:AnyObject]])?.first != nil {
            return .arrayDict
        }else if (type as? [String:AnyObject]) != nil{
            return .object
        } else if (type as? [String]) != nil {
            return .stringArray
        }   else if (type as? [Bool]) != nil{
            return .boolArray
        } else if (type as? [Int]) != nil {
            return .intArray
        } else if (type as? [Double]) != nil {
            return .doubleArray
        } else if isBool(type) {
            return .bool
        } else if(type as? Int) != nil {
            return .int
        } else if (type as? Double) != nil{
            return .double
        } else if (type as? String) != nil{
            return .string
        }else {
            return nil
        }
    }


    static func isBool(_ element: AnyObject) -> Bool {
        return type(of: element).description() == "__NSCFBoolean"
    }
}
