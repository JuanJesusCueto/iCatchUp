//
//  ClearbitLogoApiService.swift
//  iCatchUp
//
//  Created by Profesores on 11/13/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation

class ClearbitLogoApiService {
    static let logoBaseUrl = "https://logo.clearbit.com/"
    
    static func urlToLogo(forUrl urlString: String) -> String {
        if let url = URL(string: urlString) {
                return "\(logoBaseUrl)\(url.host!)"
        }
        return "\(logoBaseUrl)\(urlString)"
    }
}
