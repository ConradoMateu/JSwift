//
//  DefinitiveGenerator.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/05/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class Assembler {
    var fileNames: [String] = [String]()
    var completeRes = ""
    var numberOfFilesCreated = 0

    func transform(json: String,name: String = "Main", directory: URL? = nil){
        let dict = DictGenerator.convert(json: json)
        assemble(dict: dict!, name: name,directory: directory)
    }

    func assemble(dict: [String:AnyObject], name: String, directory: URL? = nil)  {
        for (key, value) in dict {
            if  let arrayFirst = (value as? [[String:AnyObject]])?.first{
                assemble(dict: arrayFirst, name: key, directory: directory)
            }else if let object = value as? [String:AnyObject]{
                assemble(dict: object, name: key, directory: directory)
            }
        }
        let dictPrimitiveTransformed = PrimitiveTypeHelper.transform(dict: dict)
        if !fileNames.contains(name.cleaned) {
            completeRes = SwiftGenerator.generaterFrom(dict: dictPrimitiveTransformed, name: name.cleaned, path: directory) + completeRes
            fileNames.append(name.cleaned)
            numberOfFilesCreated += 1
        }
    }
}



