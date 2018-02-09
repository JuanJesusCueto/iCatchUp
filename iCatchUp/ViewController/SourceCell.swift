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

    func setValues(fromSource source: Source) {
        nameLabel.text = source.name
        if let url = URL(string: source.urlToLogo()) {
            logoImageView.af_setImage(withURL: url)
        }
    }
    
}
