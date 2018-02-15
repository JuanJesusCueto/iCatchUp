//
//  SourcesViewController.swift
//  iCatchUp
//
//  Created by Profesores on 11/13/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class SourcesViewController: UICollectionViewController {
    var sources: [Source] = []
    var news: [News] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSources()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SourceCell
        let viewController = storyboard?.instantiateViewController(withIdentifier: "SourceDetailViewController") as! SourceDetailViewController
        viewController.source = sources[indexPath.row]
        if cell.favoriteButton.currentImage == #imageLiteral(resourceName: "highlitedHeart") {
            viewController.isFavorite = true
        } else {
            viewController.isFavorite = false
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "sourceDetail" {
            let controller = segue.destination as! SourceDetailViewController
            controller.source = sources[i]
            //controller.setViewValues(fromSource: sources[i])
        }
    }*/

}

extension SourcesViewController {
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

extension SourcesViewController {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sources.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SourceCell
        let source = sources[indexPath.row]
        // Configure the cell
        cell.setValues(fromSource: source, fromNews: news)
        return cell
    }
 // Get all the available sources from newsApi
    func updateSources() {
        //Update News Values
        if let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
            news = tabBarController.getParameters()
        }
        
        Alamofire.request(NewsApiService.sourcesUrl)
            .responseJSON(completionHandler: {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    // Update Sources Data Collection
                    self.sources = Source.from(jsonSources: json["sources"].arrayValue)
                    // Refresh Collection View
                    self.collectionView?.reloadData()
                    self.collectionViewLayout.invalidateLayout()
                    
                case .failure(let error):
                    print("\(error)")
                }
            })
    }
}
