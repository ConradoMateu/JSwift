//
//  ViewController.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Cocoa
import Bond

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var JSONTextField: NSTextField!
    @IBOutlet weak var resultField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONTextField.reactive.editingString.observeNext { text in
            if !text.isEmpty {
                let assembler = Assembler()
                assembler.assemble(json: text, name: "Main", directory: nil)
                self.resultField.stringValue = assembler.completeRes
            }
        }
    }

    @IBAction func convertJSON(_ sender: Any) {
        if !JSONTextField.stringValue.isEmpty {
            let URL = PathFinder.execute()
            Assembler().assemble(json: JSONTextField.stringValue, name: "Main", directory: URL!)
        }
    }

}

