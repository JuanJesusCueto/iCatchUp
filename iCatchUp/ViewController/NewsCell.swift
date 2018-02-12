//
//  NewsCell.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 11/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsCell: UICollectionViewCell {
    
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func setValues(fromArticle article: Article) {
        
        titleLabel.text = article.title
        if let url = URL(string: article.urlToImage) {
            articleImage.af_setImage(withURL: url)
        }
    }
}
