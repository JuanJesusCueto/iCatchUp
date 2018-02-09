//
//  ViewController.swift
//  iCatchUp
//
//  Created by Profesores on 11/10/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testNetworking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testNetworking() {
        Alamofire.request(NewsApiService.sourcesUrl)
            .responseJSON(completionHandler: {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("\(json)")
                    let sources = Source.from(jsonSources: json["sources"].arrayValue)
                    for i in 0...sources.count - 1 {
                        print("\(sources[i].name)")
                    }
                    let settings = SettingsStore()
                    
                    print("\(settings.newsApiKey)")
                    //let parameters: Parameters = ["apiKey": settings.newsApiKey, "source": "1"]
                    //Alamofire.request("", parameters: parameters)
                    
                case .failure(let error):
                    print("\(error)")
                }
            })
    }

}

