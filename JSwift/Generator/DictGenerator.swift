//
//  DictGenerator.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 01/05/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation
class DictGenerator {
    static func convert(json: String) throws -> [String: AnyObject]? {
        if let data = json.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            } catch {
                throw Errors.incorrectJSON
            }
        }
        return nil
    }
}
