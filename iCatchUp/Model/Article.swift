//
//  Article.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 11/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article {
    var source: Dictionary<String, Any>
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    init() {
        source = ["id": (Any).self, "name": (Any).self,]
        author = ""
        title = ""
        description = ""
        url = ""
        urlToImage = ""
        publishedAt = ""
    }
    
    init(from jsonArticle: JSON) {
        source = jsonArticle["source"].dictionary!
        author = jsonArticle["author"].stringValue
        title = jsonArticle["title"].stringValue
        description = jsonArticle["description"].stringValue
        url = jsonArticle["url"].stringValue
        urlToImage = jsonArticle["urlToImage"].stringValue
        publishedAt = jsonArticle["publishedAt"].stringValue
    }
    
    static func from(jsonArticles: [JSON]) -> [Article] {
        var articles: [Article] = []
        for i in 0..<jsonArticles.count {
            articles.append(Article.init(from: jsonArticles[i]))
        }
        return articles
    }
}
