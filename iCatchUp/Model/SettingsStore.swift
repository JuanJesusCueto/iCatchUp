//
//  SettingsStore.swift
//  iCatchUp
//
//  Created by Profesores on 11/10/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation

class SettingsStore {
    var newsApiKey: String {
        get {
            let path = Bundle.main.path(forResource: "Keys",
                                        ofType: "plist")
            let keys = NSDictionary(contentsOfFile: path!)
                as? [String: AnyObject]
            return keys!["NewsApiKey"] as! String
            
        }
    }
}
