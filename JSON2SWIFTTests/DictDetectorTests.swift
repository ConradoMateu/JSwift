//
//  DictDetectorTests.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 19/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSON2SWIFT

class DictDetectorTests: XCTestCase {
    var dictDetector = DictDetector()
    let arr = ["{", "Conrado", "Mateu", "itemId: 55449983", "\"image\": {"]
    let json = """
{
"itemId": 55449983,
"image": {
"thumbnail": "http://somefoto.com/thumbnail",
"medium": "http://somefoto.com/medium"
},
"price": 1234,
"categories": {
"Games": "Arcade",
"TV": "Sony"
},
}
"""

    override func tearDown() {
        super.tearDown()
        dictDetector.resDict = [:]
    }

    func testShouldAddToDictFromString() {
        let string = "itemId: 55449983"
        dictDetector.addToDictFrom(array: arr, index: 3)
        expect(self.dictDetector.resDict["itemId"] as? String).to(equal("55449983"))
    }

    func testShouldAddToDictFromKey() {
        let key = "name"
        let value = "Conrado \nMateu \n"
        dictDetector.addToDictFrom(key: key, array: arr, indexes: 1, 2)
        expect(self.dictDetector.resDict[key] as? String).to(equal(value))
    }

    func testShouldAddValuesToDictWhenHasSubcategories() {
        let arrWithSubcategories = ["\"image\": {", "\"Games\": \"Arcade\",", "\"TV\": \"Sony\"", "},"]
        dictDetector.indexDetector(arr: arrWithSubcategories, index: 0, isFirst: true)
        expect(self.dictDetector.resDict.keys.first).to(equal("\"image\""))
        expect(self.dictDetector.resDict.values.first as? String).to(equal("\"Games\": \"Arcade\", \n\"TV\": \"Sony\" \n"))
    }

    func testShouldAddCorrectlyKeysToDict() {
        dictDetector.addToDictFrom(json: json)
        expect(self.dictDetector.resDict.keys.count).to(equal(4))
    }

}
