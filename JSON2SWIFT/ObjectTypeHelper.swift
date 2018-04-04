//
//  ObjectTypeHelper.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 20/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class ObjectTypeHelper {

    static func transformObjectsFrom(dict: [String: Any]) -> [String: Any] {
        var resDict = dict
        resDict.forEach {
            let primitiveValue =  $0.value as! Primitives
            if primitiveValue == Primitives.object {
                resDict[$0.key] = $0.key.firsLetterCapitalized
            }
        }
        return resDict
    }

    static func newClassFrom(string: String) {
        let newDict = JSONHelper.generateDictFrom(string: string)
        let dict = PrimitiveTypeHelper.transform(dict: newDict)
        FileGenerator.generaterFrom(dict: dict, name: "Example")

    }
}
