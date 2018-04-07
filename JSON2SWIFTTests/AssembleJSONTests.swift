//
//  AssembleJSONTests.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 05/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSON2SWIFT

class AssembleJSONTests: XCTestCase {
    let json = """
{
"itemId": 55449983,
"1": {
"thumbnail": "http://somefoto.com/thumbnail",
"medium": "http://somefoto.com/medium"
},
"2": {
"como": "http://somefoto.com/thumbnail",
"3": {
"cfdfsomo": "http://somefoto.com/thumbnail",
"essdfdsftas": "http://somefoto.com/medium"
},
},
"price": 1234
}
"""

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testShouldAssembleTheExactNumberOfFiles() {
        let assembler = Assembler()
        assembler.assemble(json: json, name: "Main")
        expect(assembler.counter).to(equal(4))
    }

}
