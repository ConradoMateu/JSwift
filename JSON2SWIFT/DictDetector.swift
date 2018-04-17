//
//  NewDictDetector.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 26/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class DictDetector {
    var resDict: [String: Any] = [:]

    func addToDictFrom(json: String) {
        var line = json.components(separatedBy: "\n")
        line.removeFirst()
        line.removeLast()
        line = line.filter {$0 != "}"}
        indexDetector(arr: line, index: 0, isFirst: true)
    }

    func addToDictFrom(array: [String], index: Int) {
//        let element = array[index].split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        let element = array[index].components(separatedBy: ": ")
            let keyCleaned = String(element[0]).cleaned
            var value = ""
            if element.count > 1 {
                value = String(element[1]).cleanValue()
                self.resDict[keyCleaned] = value
            }

    }

    func addToDictFrom(key: String, array: [String], indexes: Int..., isArray: Bool) {
        var value = ""
        if(isArray) {value.append("##isArray##")}
        for index in indexes.first!...indexes.last! {
            value += array[index] + " \n"
        }
        resDict[key]  = value
    }

    var openBraces = [Int]()
    var closeBraces = [Int]()

    func indexDetector(arr: [String], index: Int, isFirst: Bool) {
        let value = arr[index]
        let stillOpenBrace = !openBraces.isEmpty || value.contains("{")
        if stillOpenBrace {
            if value.contains(": {") {
                openBraces.append(index)
                var current = index
                while !openBraces.isEmpty {
                    current += 1
                    if(arr[current].contains("{")) {
                        openBraces.append(current)
                    } else if(arr[current].contains("},")) {
                        let lastOpenBrace = openBraces.removeLast()
                        let key = value.components(separatedBy: ": ").first
                        if(openBraces.isEmpty) {addToDictFrom(key: key!, array: arr, indexes: lastOpenBrace+1, current-1, isArray: false)}
                        if(current+1<arr.count) {indexDetector(arr: arr, index: current+1, isFirst: false)}
                    }
                }
            }
        } else if(value.contains(": [")) {
            var current = index
            var found = false
            var opener = -1
            while !found {
                if(arr[current].contains("{")) {opener = current
                } else if(arr[current].contains("},")) {
                    let key = value.components(separatedBy: ": ").first
                    found = true
                    addToDictFrom(key: key!, array: arr, indexes: opener+1, current-1, isArray: true)
                }
                current += 1
            }
            while !(arr[current] == "]") {current += 1}
            if(current+1<arr.count) {indexDetector(arr: arr, index: current+1, isFirst: false)}
        } else {
            addToDictFrom(array: arr, index: index)
            if(index+1<arr.count) {indexDetector(arr: arr, index: index+1, isFirst: false)}
            }
    }
}
