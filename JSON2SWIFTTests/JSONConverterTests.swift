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
        let res = JSONConverter().ConvertJSONFrom(dict: dictDetectorRes?.resDict as! [String : String])
        let dictDetectorForConvertedJSON = DictDetector()
        dictDetectorForConvertedJSON.addToDictFrom(json: res)
        print(dictDetectorForConvertedJSON.resDict)
        print(self.dictDetectorRes!.resDict)
        expect(dictDetectorForConvertedJSON.resDict as NSDictionary == self.dictDetectorRes!.resDict as NSDictionary).to(beTrue())
    }

}
