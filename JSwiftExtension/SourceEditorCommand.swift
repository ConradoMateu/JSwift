//
//  SourceEditorCommand.swift
//  JSwiftExtension
//
//  Created by Conrado Mateu Gisbert on 09/05/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation
import XcodeKit
import Cocoa
import JSON2SWIFT


class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        var json = ""
        if invocation.commandIdentifier == "JSwiftXcode" {
            json = getStringFromXCodeSelection(invocation: invocation)!
        } else if invocation.commandIdentifier == "JSwiftClipboard" {
            json = getStringFromClipboard()!
        }

        let range = invocation.buffer.selections.firstObject as! XCSourceTextRange
        let endLineIndex = range.end.line + 2
        let assembler = Assembler()
        do{
            try assembler.transform(json: json)
            print(assembler.completeRes) //without this line is not working xD
            let res = reduceDictValues(dict: assembler.completeRes)
            invocation.buffer.lines.insert(res, at: endLineIndex)
        }catch let error as NSError {
            print(error.description)
        }
        completionHandler(nil)
    }

    func getStringFromClipboard() -> String? {
        return NSPasteboard.general.string(forType: .string)
    }

    func getStringFromXCodeSelection(invocation: XCSourceEditorCommandInvocation) -> String? {
        let range = invocation.buffer.selections.firstObject as! XCSourceTextRange
        var jsonString: String = ""
        for index in range.start.line..<range.end.line {
            jsonString += invocation.buffer.lines[index] as! String
        }
        return jsonString
    }

    func reduceDictValues(dict: [String:String]) -> String{
        return dict.reduce("", {$0 + "\n" + $1.value})
    }

    
}
