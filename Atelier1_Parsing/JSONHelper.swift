//
//  JSONHelper.swift
//  Atelier1_Parsing
//
//  Created by CedricSoubrie on 12/10/2017.
//  Copyright © 2017 CedricSoubrie. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

extension FileManager {
    static func jsonArray (fromJSONFile fileName:String) -> [JSON] {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print ("No local json files for path \(fileName)")
            return []
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let array = json as? [JSON] {
                return array
            }
            else {
                print("\(fileName) doens't contain an array")
                return []
            }
        }
        catch {
            print("Could not get json from file, make sure that file \(fileName) contains valid json.")
            return []
        }
    }
}
