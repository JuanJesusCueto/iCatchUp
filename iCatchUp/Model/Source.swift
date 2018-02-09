//
//  Source.swift
//  iCatchUp
//
//  Created by Profesores on 11/10/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Source {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
    var sortBysAvailable: [String]
    
    init() {
        id = ""
        name = ""
        description = ""
        url = ""
        category = ""
        language = ""
        country = ""
        sortBysAvailable = []
    }
    
    init(from jsonSource: JSON) {
        id = jsonSource["id"].stringValue
        name = jsonSource["name"].stringValue
        description = jsonSource["description"].stringValue
        url = jsonSource["url"].stringValue
        category = jsonSource["category"].stringValue
        language = jsonSource["language"].stringValue
        country = jsonSource["country"].stringValue
        let jsonSortBysAvailable = jsonSource["sortBysAvailable"].arrayValue
        let count = jsonSortBysAvailable.count
        sortBysAvailable = []
        for i in 0...count - 1 {
            sortBysAvailable.append(jsonSortBysAvailable[i].stringValue)
        }
    }
    
    func urlToLogo() -> String {
        return ClearbitLogoApiService.urlToLogo(forUrl: url)
    }
    
    static func from(jsonSources: [JSON]) -> [Source] {
        var sources: [Source] = []
        let count = jsonSources.count
        for i in 0...count - 1 {
            sources.append(Source.init(from: jsonSources[i]))
        }
        return sources
    }
}
