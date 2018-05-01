//
//  RegexTests.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 29/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSON2SWIFT

class RegexTests: XCTestCase {
    var json: String = ""
    var dictResult: [String: Any] = [:]

    override func setUp() {
        super.setUp()
    }

    func testShouldGetKey() {
        let element = "\"Key\": [{\"hello\": \"friend\"}, {\"hello\": \"enemy\"}]"
        let key = Regex.getKey(of: element)
        expect(key).to(equal("\"Key\""))
    }

    func testShouldGetKeyNotCleaned() {
        let element = "\"Key\": [{\"hello\": \"friend\"}, {\"hello\": \"enemy\"}]"
        let key = Regex.getKeyNotCleaned(of: element)
        expect(key).to(equal("\"Key\": "))
    }

    // "Conrado": [smth] --> returns [smth],
    func testShouldGetInnerArray() {
        let element = "\"Key\": [{\"hello\": \"friend\"}, {\"hello\": \"enemy\"}]"
        let array = Regex.getInnerArray(of: element)
        expect(array).to(equal("[{\"hello\": \"friend\"}, {\"hello\": \"enemy\"}]"))
    }

    func testShouldGetInnerObject() {
        let element = "\"Key\": {\"hello\": \"friend\"}]"
        let object = Regex.getInnerObject(of: element)
        expect(object).to(equal("{\"hello\": \"friend\"}"))
    }

    func testShouldGetArrayObjects() {

    }

}


