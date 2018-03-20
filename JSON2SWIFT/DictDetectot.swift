//
//  DictDetectot.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation

class DictDetector {


    static func detectInnerDicts() -> [String:Any] {
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
        var line = json.components(separatedBy: "\n")
        line.removeFirst()
        var resDict : [String: Any] = [:]
        var afterKey = ""
        var afterInner = false
        var afterAdded = false
        for (_, l) in line.enumerated(){
            var element = l.components(separatedBy: ": ")
            let keyCleaned = element[0]

            var value: String? = nil
            if element.count != 1{
                value = element[1].cleaned
            }else{
                value = ""
            }
            if(afterInner || afterAdded){
                if(afterInner){

                        resDict[afterKey] = keyCleaned + ": " + value! + "\n"

                    afterInner = false
                    afterAdded = true
                    
                }else if(afterAdded){
                    //If value is empty "}".componentsSeparatedBY(",n") just one item in the array
                    if(keyCleaned.contains("}")){
                        afterAdded = false
                    }else{
                        resDict[afterKey] = resDict[afterKey] as! String + keyCleaned + ": " + value! + "\n"
                        afterAdded = true
                    }
                }
            }else{
                if let v = value {
                    if(v.contains("{")){
                        afterInner = true
                                            afterKey = keyCleaned
                    }else{
                        if(!keyCleaned.contains("}")){
                            resDict[keyCleaned] = v.replacingOccurrences(of: "}", with: "")
                        }
                    }
                }
            }
        }
return resDict

}



}


