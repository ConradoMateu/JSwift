//
//  JSON.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 29/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation
@testable import JSwift

class JSON {
    func get(named: String) -> String? {
        // File location
        let testBundle = Bundle(for: type(of: self))
        let fileURL = testBundle.url(forResource: named, withExtension: "json")
        do {
            let data = try String(contentsOf:fileURL!,  encoding: String.Encoding.utf8)
            return data
        } catch {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
            return nil
        }
    }
}
