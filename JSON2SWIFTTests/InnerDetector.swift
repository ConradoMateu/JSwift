//
//  InnerDetector.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 28/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSON2SWIFT

class InnerDetectorTests: XCTestCase {
    var json: String = ""
    var dictResult: [String: Any] = [:]

    override func setUp() {
        super.setUp()

    }

    func testGenerateDictFromJSON() {
        let json = JSON().get(named: "Data")
        let inners: [String] = InnerDetector.detectInners(json: json!)
        expect(inners.count).to(equal(5))
    }
}

