//
//  SourceDetailViewController.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 3/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit

class SourceDetailViewController: UIViewController {

    var source: Source!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    var isFavorite: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(SourceDetailViewController.tapFunction))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        if isFavorite == true {
            favoriteButton.setImage(#imageLiteral(resourceName: "highlitedHeart"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
        setViewValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        if let url = URL(string: source.url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func setViewValues() {
        descriptionLabel.text = source.description
        urlLabel.text = source.url
        nameLabel.text = source.name
        if let url = URL(string: source.urlToLogo()) {
            logoImageView.af_setImage(withURL: url)
        }
    }

    @IBAction func setFavorite(_ sender: UIButton) {
        
        let alertController: UIAlertController!
        let defaultAction: UIAlertAction!
        if isFavorite == false {
            isFavorite = true
            alertController = UIAlertController(title: "Add Favorite", message: "The Source " + source.name + " has been added to favorites", preferredStyle: .alert)
            defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.dataController.saveSource(source: self.source, isFavorite: self.isFavorite)
            })
            favoriteButton.setImage(#imageLiteral(resourceName: "highlitedHeart"), for: .normal)
        } else {
            isFavorite = false
            alertController = UIAlertController(title: "Add Favorite", message: "The Source " + source.name + " has been removed of favorites", preferredStyle: .alert)
            defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.dataController.saveSource(source: self.source, isFavorite: self.isFavorite)
            })
            favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
