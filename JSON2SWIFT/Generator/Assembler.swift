//
//  Launcher.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 28/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class Assembler {
    var fileNames: [String] = [String]()
    var completeRes = ""
    var numberOfFilesCreated = 0
    func assemble(json: String, name: String, directory: URL? = nil)  {
        let newString = json.cleanFirstBrace()
        let inners = InnerDetector.detectInners(json: newString)
        var innersDict: [String: String] = [:]
        inners.forEach {
            let elem = element(of: $0)
            innersDict[elem.0] = elem.1
        }
        for (key, value) in innersDict {
            let primitive = PrimitiveTypeHelper.infer(type: value)
            if  primitive == Primitives.array {
                assemble(json: value.cleanBrackets(), name: key, directory: directory)
            }else if primitive == Primitives.object{
                assemble(json: value.cleanBraces(), name: key, directory: directory)
            }
        }

        let dictPrimitiveTransformed = PrimitiveTypeHelper.transform(dict: innersDict)
        if !fileNames.contains(name.cleaned) {
            completeRes = SwiftGenerator.generaterFrom(dict: dictPrimitiveTransformed, name: name.cleaned, path: directory) + completeRes
            fileNames.append(name.cleaned)
            numberOfFilesCreated += 1
        }

    }

    //gets key and value of an element
    func element(of string:String) -> (String, String) {
        let notCleanedKey = Regex.getKeyNotCleaned(of: string)
        let value = string.stringByReplacingFirstOccurrenceOfString(target: notCleanedKey!, withString: "")
        let keycleaned = notCleanedKey?.firstKeyCleaned()
        return (keycleaned!, value)
    }
}
