//
//  JSONHelperTests.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSON2SWIFT

class JSONHelperTests: XCTestCase {
    var json: String = ""
    var dictResult: [String: Any] = [:]

    override func setUp() {
        super.setUp()
        json = """
        {
            "name": "Conrado",
            "age": 21,
        }
        """
        dictResult = ["name": "\"Conrado\"", "age": "21"]
    }

    func testGenerateDictFromJSON() {
        let generatedDict = JSONHelper.generateDictFrom(JSON: json)
        expect(generatedDict as NSDictionary == self.dictResult as NSDictionary).to(beTrue())
    }
}

