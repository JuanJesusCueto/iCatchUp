//
//  DataController.swift
//  iCatchUp
//
//  Created by Juan Jesus Cueto Yabar on 10/02/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let managedObjectContext: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.managedObjectContext = moc
    }
    
    convenience init?() {
        
        guard let modelURL = Bundle.main.url(forResource: "iCatchUp", withExtension: "momd") else {
            return nil
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            return nil
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let persistantStoreFileURL = urls[0].appendingPathComponent("Bookmarks.sqlite")
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store")
        }
        self.init(moc: moc)
    }
    
    func saveSource(source: Source, isFavorite: Bool) {
        let newsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        newsFetch.predicate = NSPredicate(format: "name==%@", source.id)
        
        var fetchedNews: [News]!
        do {
            fetchedNews = try self.managedObjectContext.fetch(newsFetch) as! [News]
        } catch {
            fatalError("Fetch Failed")
        }
        
        var news: News
        if fetchedNews.count == 0 {
            news = NSEntityDescription.insertNewObject(forEntityName: "News", into: self.managedObjectContext) as! News
            news.name = source.id
        } else {
            news = fetchedNews[0]
        }
        
        news.isFavorite = isFavorite
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
}
