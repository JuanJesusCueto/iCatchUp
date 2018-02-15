//
//  SourceCell.swift
//  iCatchUp
//
//  Created by Profesores on 11/13/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import AlamofireImage

class SourceCell: UICollectionViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    func setValues(fromSource source: Source, fromNews news: [News]) {
        for i in 0..<news.count {
            if ((news[i].name == source.id) && (news[i].isFavorite == true)) {
                self.favoriteButton.setImage(#imageLiteral(resourceName: "highlitedHeart"), for: .normal)
                break
            } else {
                self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            }
        }
        nameLabel.text = source.name
        if let url = URL(string: source.urlToLogo()) {
            logoImageView.af_setImage(withURL: url)
        }
    }
    
}
