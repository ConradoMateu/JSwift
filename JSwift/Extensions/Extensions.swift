//
//  Extensions.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 02/03/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

extension String {

    var cleaned: String {
        return self.replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "\n", with: "")
        .replacingOccurrences(of: ",", with: "")
        .replacingOccurrences(of: " ", with: "")
    }

    var firsLetterCapitalized: String {
        return prefix(1).uppercased() + dropFirst()
    }


}


