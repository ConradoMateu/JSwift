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



class ViewController: NSViewController, NSTextFieldDelegate, NSTextViewDelegate {
    var lastRes: [String:String] = [:]


    @IBOutlet weak var saveFilesButton: NSButton!
    @IBOutlet weak var resultField: NSTextField!
    @IBOutlet var JSONTextField: NSTextView!
    @IBOutlet weak var JSONScrollView: NSScrollView!
    @IBOutlet var resultView: NSTextView!

    @IBAction func openJSONFIle(_ sender: Any) {
        if let url = PathFinder.execute(withDirectory: false) {
            let fileOpened = FileGenerator.openJSON(fileURL: url)
            generateJSON(text: fileOpened!)

        }
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
                self.cleanResultField()
                self.generateJSON(text: text)

            }
        }
    }
}

extension ViewController {
    func cleanResultField(){
        self.resultView.layoutManager?.replaceTextStorage(NSTextStorage(attributedString: NSMutableAttributedString(string: "")))
    }
    func generateJSON(text: String) {
        self.JSONTextField.string = ""
        self.JSONTextField.textStorage?.append(self.highlight(language: "json", theme: "paraiso-dark", text: text)!)
        let assembler = Assembler()

        do{
            try assembler.transform(json: text)
            self.saveFilesButton.isHidden = false
        }  catch Errors.incorrectJSON {
            self.showNotification()
        } catch let error as NSError {
            print(error.description)
        }

        lastRes = assembler.completeRes
            self.resultView.textStorage?.append(self.highlight(language: "swift", theme: "paraiso-dark", text: reduceDictValues(dict: lastRes))!)

    }

    func reduceDictValues(dict: [String:String]) -> String{
        return dict.reduce("", {$0 + "\n" + $1.value})
    }

    func showNotification() -> Void {
        var notification = NSUserNotification()
        notification.title = "Error"
        notification.informativeText = "Incorrect JSON Format"
        NSUserNotificationCenter.default.deliver(notification)
    }


    func highlight(language: String, theme: String, text: String) -> NSAttributedString? {
        let highlightr = Highlightr()
        highlightr?.setTheme(to: theme)
        return highlightr?.highlight(text, as: language)
    }
}

