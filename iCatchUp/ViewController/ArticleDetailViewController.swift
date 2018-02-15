//
//  ArticleDetailViewController.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 12/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var article: Article = Article()
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArticleDetailViewController.tapFunction))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tap)
        setViewValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    func setViewValues() {
        
        if let url = URL(string: article.urlToImage) {
            articleImage.af_setImage(withURL: url)
        }
        authorLabel.text = article.author
        titleLabel.text = article.title
        dateLabel.text = article.publishedAt
        descriptionLabel.text = article.description
        urlLabel.text = article.url
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the select
     ed object to the new view controller.
    }
    */

}
