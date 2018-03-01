//
//  PrimitiveTypeHelper.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation


class PrimitiveTypeHelper {

    static func transform(dict: [String:Any]) -> [String:Any]{
        var res: [String:Any] = [:]
        for (key,_) in dict{
            res[key] = infer(type: dict[key] as! String)
        }
        return res
    }
    static func infer(type: String) -> Primitives {
        if (type.starts(with: "\"") && type.reversed().starts(with: "\"")){
            return Primitives.String
        }else if(type.isNumeric){
            return numericInfer(type: type)
        }else{
            return Primitives.Bool
        }
    }


    static func numericInfer(type: String) -> Primitives{
        if(type.contains(".")){
            return Primitives.Double
        }
        else{ return Primitives.Int
    }
}
}


extension String {
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
}
