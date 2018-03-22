//
//  HomeNewsViewController.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 11/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

private let reuseIdentifier = "Cell"

class HomeNewsViewController: UICollectionViewController {

    var articles: [Article] = []
    var newsValues: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
       // updateArticles()
    }

    override func viewWillAppear(_ animated: Bool) {
        articles.removeAll()
        updateArticles()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        viewController.article = articles[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


}

extension HomeNewsViewController {
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        let article = articles[indexPath.row]
        // Configure the cell
        cell.setValues(fromArticle: article)
        return cell
    }
    
    func updateArticles() {
        // This var will determinate whether the articles are empty or not in this function
        var validate = 0
        var parameters: [String:String] = [
            "sources": "bbc-news",
            "apiKey":"fecf4feeffa64e4da682e7d268612ce5",
            ]
        
        //Update the values from TabBarController
        if let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
            newsValues = tabBarController.getParameters()
        }
        if newsValues.count > 0 {
          for i in 0..<newsValues.count {
            //Update the value of sources if they are favorites
            if newsValues[i].isFavorite == true {
            parameters.updateValue(newsValues[i].name!, forKey: "sources")
            articlesRequest(parameters: parameters)
                validate+=1
          }
        }
      }
        if (validate == 0) {
          articlesRequest(parameters: parameters)
      }
    }
    
    func articlesRequest(parameters: [String: String]) {
        Alamofire.request(NewsApiService.articlesTopUrl, method: .get, parameters: parameters)
            .responseJSON { (response) -> Void in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("\(json)")
                    // Update Articles Data Collection
                    self.articles.append(contentsOf: Article.from(jsonArticles: json["articles"].arrayValue))
                    // Refresh Collection View
                    self.collectionView?.reloadData()
                    self.collectionViewLayout.invalidateLayout()
                    
                case .failure(let error):
                    print("\(error)")
                }
        }
    }
}

extension HomeNewsViewController {
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
