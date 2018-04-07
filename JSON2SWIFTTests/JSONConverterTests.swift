//
//  JSONConverter.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 03/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSON2SWIFT

class JSONConverterTests: XCTestCase {

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
    var dictDetectorRes: DictDetector?
    override func setUp() {
        super.setUp()
        dictDetectorRes = DictDetector()
        dictDetectorRes?.addToDictFrom(json: json)
    }

    func testDictionaryGeneratedShouldBeEqualToGiven() {
        let res = JSONConverter().convertJSONFrom(dict: dictDetectorRes?.resDict as! [String: String])
        let dictDetectorForConvertedJSON = DictDetector()
        dictDetectorForConvertedJSON.addToDictFrom(json: res)
        expect(dictDetectorForConvertedJSON.resDict.keys).to(equal(self.dictDetectorRes!.resDict.keys))
        for (key, value) in dictDetectorForConvertedJSON.resDict{
            expect(value as? String).to(equal(self.dictDetectorRes!.resDict[key] as? String))
        }
    }

}
