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
    var completeRes: [String:String] = [:]
    var numberOfFilesCreated = 0

    func transform(json: String, name: String = "Main") throws {
        do{
            let dict = try DictGenerator.convert(json: json)
             assemble(dict: dict!, name: name)
        } catch Errors.incorrectJSON {
            throw Errors.incorrectJSON
        }


    }

    func assemble(dict: [String:AnyObject], name: String)  {
        for (key, value) in dict {
            if  let arrayFirst = (value as? [[String:AnyObject]])?.first {
                assemble(dict: arrayFirst, name: key)
            }else if let object = value as? [String:AnyObject] {
                assemble(dict: object, name: key)
            }
        }
        let dictPrimitiveTransformed = PrimitiveTypeHelper.transform(dict: dict)
        if !fileNames.contains(name.cleaned) {
            completeRes[name] = SwiftGenerator.generaterFrom(dict: dictPrimitiveTransformed, name: name.cleaned)
            fileNames.append(name.cleaned)
            numberOfFilesCreated += 1
        }
    }
}



