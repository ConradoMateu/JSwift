//
//  PrimitiveTypeHelperTests.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble

class PrimitiveTypeHelperTests: XCTestCase {
    var dict: [String:Any] = [:]
    var dictResult: [String:Any] = [:]

    override func setUp() {
        super.setUp()
        dict = ["name": "\"Conrado\"",
                    "surname": "\"Mateu Gisbert\"",
                    "isStudent": "true",
                    "age": "21",
                    "averageGrade": "9.9"]
        dictResult = ["name": Primitives.String,
                         "surname": Primitives.String,
                         "isStudent": Primitives.Bool,
                         "age": Primitives.Int,
                         "averageGrade": Primitives.Double]
    }

    func testNumericInferShouldReturnDoubleIfTheStringContainsADot(){
        let stringToInfer = "34.234"
        let infer = PrimitiveTypeHelper.numericInfer(type: stringToInfer)
        expect(infer).to(equal(Primitives.Double))
    }

    func testNumericInferShouldReturnIntIfTheStringDoesNotContainsADot(){
        let stringToInfer = "34234"
        let infer = PrimitiveTypeHelper.numericInfer(type: stringToInfer)
        expect(infer).to(equal(Primitives.Int))
    }

    func testInferShouldReturnStringIfContainsQuotes(){
        let stringToInfer = "\"I am a string\""
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer)
        expect(infer).to(equal(Primitives.String))
    }

    func testInferShouldReturnBool(){
        let stringToInfer = "true"
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer)
        expect(infer).to(equal(Primitives.Bool))
    }

    func testInferShouldReturnDoubleIfTheStringContainsADot(){
        let stringToInfer = "34.234"
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer)
        expect(infer).to(equal(Primitives.Double))
    }

    func testInferShouldReturnIntIfTheStringDoesNotContainsADot(){
        let stringToInfer = "34234"
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer)
        expect(infer).to(equal(Primitives.Int))
    }

    func testPrimitiveValuesFromTransformedDictionary(){
        let transformedDict = PrimitiveTypeHelper.transform(dict: dict)
        for (key,value) in transformedDict{
            expect(value as! Primitives == self.dictResult[key] as! Primitives).to(beTrue())
        }
    }
}


