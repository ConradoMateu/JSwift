//
//  ViewController.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var JSONField: NSTextField!
    @IBOutlet weak var pathField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func convertJSON(_ sender: Any) {
        let URL = PathFinder.execute()
        Assembler().assemble(json: JSONField.stringValue, name: "Main", directory: URL!)
    }

}

