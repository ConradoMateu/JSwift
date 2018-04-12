//
//  Assembler.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 06/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class Assembler {
    var counter = 1
    func assemble(json: String, name: String, directory: URL) {
        let dictDetector = DictDetector()
        let detectedInners = dictDetector.addToDictFrom(json: json)
        var innerDictsJSON: [String: String] = [:]
        for (key, value) in dictDetector.resDict {
            let stringVal = value as! String
            let primitive = PrimitiveTypeHelper.infer(type: stringVal)
            if  primitive == Primitives.object {
                assemble(json: JSONConverter.buildDictFrom(objectString: stringVal), name: key, directory: directory)
                counter += 1
            }
        }
        let dictPrimitiveTransformed = PrimitiveTypeHelper.transform(dict: dictDetector.resDict)
        FileGenerator.generaterFrom(dict: dictPrimitiveTransformed, name: name.cleaned, directory: directory)

    }
}
