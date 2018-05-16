//
//  PrimitiveTypeHelperTests.swift
//  JSON2SWIFTTests
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import XCTest
import Nimble
@testable import JSwift

class PrimitiveTypeHelperTests: XCTestCase {
    var dict: [String: Any] = [:]
    var dictResult: [String: Any] = [:]

    override func setUp() {
        super.setUp()
        dict = ["name": "\"Conrado\"",
                    "surname": "\"Mateu Gisbert\"",
                    "isStudent": true,
                    "age": 21,
                    "averageGrade": 9.9,
                    "object": ["hello": "friend"],
                    "array": [["hello": "friend"], ["adios": "amigo"]],
                    "boolArray": [true,false,true],
                    "doubleArray": [324.3,432.423],
                    "intArray": [123, 324, 324],
                    "stringArray": ["Hello","Hola"]]
        dictResult = ["name": Primitives.string,
                         "surname": Primitives.string,
                         "isStudent": Primitives.bool,
                         "age": Primitives.int,
                         "averageGrade": Primitives.double,
                         "object": Primitives.object,
                         "array": Primitives.arrayDict,
                         "boolArray": Primitives.boolArray,
                         "doubleArray": Primitives.doubleArray,
                         "intArray": Primitives.intArray,
                         "stringArray": Primitives.stringArray]
    }

    func testNumericInferShouldReturnDoubleIfTheStringContainsADot() {
        let stringToInfer = 34.234
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.double))
    }

    func testNumericInferShouldReturnIntIfTheStringDoesNotContainsADot() {
        let stringToInfer = 34234
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.int))
    }

    func testInferShouldReturnStringIfContainsQuotes() {
        let stringToInfer = "\"I am a string\""
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.string))
    }

    func testInferShouldReturnBool() {
        let stringToInfer = true as AnyObject
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer)
        expect(infer).to(equal(Primitives.bool))
    }

    func testInferShouldReturnDoubleIfTheStringContainsADot() {
        let stringToInfer = 34.234
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.double))
    }

    func testInferShouldReturnIntIfTheStringDoesNotContainsADot() {
        let stringToInfer = 34234
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.int))
    }

    func testInferShouldReturnObject() {
        let stringToInfer = ["hello": "friend"]
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.object))
    }

    func testInferShouldReturnArray() {
        let stringToInfer = [["hello": "friend"], ["adios": "amigo"]]
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.arrayDict))
    }

    func testInferShouldReturnBoolArray() {
        let stringToInfer: [Bool] = [true]
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.boolArray))
    }

    func testInferShouldReturnIntArray() {
        let stringToInfer = [123, 324, 324]
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.intArray))
    }

    func testInferShouldReturnDoubleArray() {
        let stringToInfer = [324.3, 432.423]
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.doubleArray))
    }

    func testInferShouldReturnStringArray() {
        let stringToInfer = ["Hello", "Hola"]
        let infer = PrimitiveTypeHelper.infer(type: stringToInfer as AnyObject)
        expect(infer).to(equal(Primitives.stringArray))
    }

    func testPrimitiveValuesFromTransformedDictionary() {
        let transformedDict = PrimitiveTypeHelper.transform(dict: dict as [String : AnyObject])
        for (key, value) in transformedDict {
            expect(value as! Primitives == self.dictResult[key] as! Primitives).to(beTrue())
        }
    }
}

