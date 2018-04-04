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
        indexDetector(arr: line, index: 0)
    }

    func addToDictFrom(array: [String], index: Int) {
            let element = array[index].components(separatedBy: ": ")
            let keyCleaned = element[0]
            var value = ""
            if element.count > 0 {
                value = element[1].cleanValue()
            }
            self.resDict[keyCleaned] = value
    }

    func addToDictFrom(key: String, array: [String], indexes: Int...) {
        var value = ""
        indexes.forEach {value = value + array[$0] + " \n"}
        resDict[key]  = value
    }

    func indexDetector(arr: [String], index: Int) {
        let value = arr[index]
            if(value.contains(": {")) {
                var current = index
                var found = false
                while(!found) {
                    current += 1
                    if(arr[current].contains("},")) {
                        found = true
                        let key = value.components(separatedBy: ": ").first
                        addToDictFrom(key: key!, array: arr, indexes: index+1, current-1)
                        if(current+1<arr.count) {indexDetector(arr: arr, index: current+1)}
                    }
                }
            } else {
                addToDictFrom(array: arr, index: index)
                if(index+1<arr.count) {indexDetector(arr: arr, index: index+1)}
            }
    }
}
