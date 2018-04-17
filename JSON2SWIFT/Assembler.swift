//
//  Assembler.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 06/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class Assembler {
    var counter: Int = 1
    var completeRes: String = ""

    func assemble(json: String, name: String, directory: URL? = nil) {
        let dictDetector = DictDetector()
        let detectedInners = dictDetector.addToDictFrom(json: json)
        var innerDictsJSON: [String: String] = [:]
        for (key, value) in dictDetector.resDict {
            let stringVal = value as! String
            let primitive = PrimitiveTypeHelper.infer(type: stringVal)
            if  primitive == Primitives.object || primitive == Primitives.array {
                assemble(json: JSONConverter.buildDictFrom(objectString: stringVal), name: key, directory: directory)
                counter += 1
            }
        }
        let dictPrimitiveTransformed = PrimitiveTypeHelper.transform(dict: dictDetector.resDict)
        completeRes = SwiftGenerator.generaterFrom(dict: dictPrimitiveTransformed, name: name.cleaned, path: directory) + completeRes

    }
}
