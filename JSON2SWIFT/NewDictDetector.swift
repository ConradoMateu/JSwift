//
//  NewDictDetector.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 26/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class NewDictDetector {
    var resDict: [String:Any] = [:]
    let json = """
{
"itemId": 55449983,
"upc": {
"categoryPath": "Video Games/Nintendo Switch/Nintendo Switch Consoles",
"shortDescription": "Nintendo Switch is a unique hybrid system that blurs the line between console gaming and mobile play. With its modular "
},
"dsad": 243324234234,
"3432": {
"23432444": "Video Games/Nintendo Switch/Nintendo Switch Consoles",
"4234234": "Nintendo Switch is a unique hybrid system that blurs the line between console gaming and mobile play. With its modular "
},
}
"""

    func getIndexedFrom(){
        var line = json.components(separatedBy: "\n")
        line.removeFirst()
        line.removeLast()
        indexDetector(arr: line,index: 0)
    }

    func addToDictFrom(array: [String], indexes: Int...){
        indexes.forEach{
            let element = array[$0].components(separatedBy: ": ")
            let keyCleaned = element[0]
            var value = ""
            if element.count != 1{
                value = element[1].cleaned
            }
            self.resDict[keyCleaned] = value
        }
    }

    func addToDictFrom(key: String, array: [String], indexes: Int...) {
        var value = ""
        indexes.forEach{value = value + array[$0] + "\n"}
        resDict[key]  = value
    }

    func indexDetector(arr: [String], index:Int){
        let value = arr[index]
            if(value.contains(": {")){
                let begining = index
                var encontrado = false
                var current = index
                while(!encontrado){
                    current = current+1
                    if(arr[current].contains("},")){
                        encontrado = true
                        let key = value.components(separatedBy: ": ").first
                        addToDictFrom(key:key!, array: arr, indexes: begining+1,current-1)
                        if(current+1<arr.count){indexDetector(arr: arr,index: current+1)}
                    }
                }
            }else{
                addToDictFrom(array: arr, indexes: index)
                if(index+1<arr.count){indexDetector(arr: arr,index: index+1)}
            }

    }

}
