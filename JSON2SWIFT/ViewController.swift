//
//  ViewController.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Cocoa
import Bond
import Highlightr
import FlatButton


class ViewController: NSViewController, NSTextFieldDelegate, NSTextViewDelegate {
    var lastRes: [String:String] = [:]

    @IBOutlet weak var resultField: NSTextField!
    @IBOutlet var JSONTextField: NSTextView!
    @IBOutlet weak var JSONScrollView: NSScrollView!
    @IBOutlet var resultView: NSTextView!

    @IBAction func openJSONFIle(_ sender: Any) {
        let fileOpened = FileGenerator.openJSON(fileURL: PathFinder.execute(withDirectory: false)!)
        generateJSON(text: fileOpened!)

    }

    @IBAction func saveSwiftFIles(_ sender: Any) {
        if !resultView.string.isEmpty {
            let path = PathFinder.execute(withDirectory: true)
            if let path = path {
                lastRes.forEach {
                    FileGenerator.generaterFrom(name: $0, text: $1, directory: path)
                }
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        JSONTextField.reactive.string.observeNext { text in
            if !text.isEmpty {
                self.generateJSON(text: text)
            }
        }
    }
}

extension ViewController {

    func generateJSON(text: String) {
        self.JSONTextField.string = ""
        self.JSONTextField.textStorage?.append(self.highlight(language: "json", theme: "paraiso-dark", text: text)!)
        let assembler = Assembler()
        assembler.transform(json: text)
        lastRes = assembler.completeRes
        self.resultView.textStorage?.append(self.highlight(language: "swift", theme: "paraiso-dark", text: reduceDictValues(dict: lastRes))!)
    }

    func reduceDictValues(dict: [String:String]) -> String{
        return dict.reduce("", {$0 + "\n" + $1.value})
    }

    func highlight(language: String, theme: String, text: String) -> NSAttributedString? {
        let highlightr = Highlightr()
        highlightr?.setTheme(to: theme)
        return highlightr?.highlight(text, as: language)
    }
}

