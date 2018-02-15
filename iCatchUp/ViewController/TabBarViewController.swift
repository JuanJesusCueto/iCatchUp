//
//  TabBarViewController.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 13/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit
import CoreData

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getParameters() -> [News] {
        
        var values: [News] = []
        // Get the managed object context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc = appDelegate.dataController.managedObjectContext
        
        //Get the table from the request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let results = try moc.fetch(request)
            if let constants = results as? [News] {
                values = constants
            }
        } catch {
            print("Could not fetch")
        }
        return values
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
