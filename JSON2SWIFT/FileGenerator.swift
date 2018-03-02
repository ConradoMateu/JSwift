//
//  FileGenerator.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class FileGenerator {
    static func generaterFrom(dict: [String:Any]){
        do {
            // get the documents folder url
            if let documentDirectory =

                FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = documentDirectory.appendingPathComponent("test.txt")
                // define the string/text to be saved
                let text = correctFormatFrom(dict: dict)
                // writing to disk
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                print("saving was successful")
                // any code posterior code goes here
                // reading from disk
                let savedText = try String(contentsOf: fileURL)
                print("savedText:", savedText)   // "Hello World !!!\n"
            }
        } catch {
            print("error:", error)
        }
    }

    static func correctFormatFrom(dict:[String:Any])-> String{
        var res = ""
        dict.forEach{
            res.append("\($0): \($1)? \n")
        }
        return res
    }
}
