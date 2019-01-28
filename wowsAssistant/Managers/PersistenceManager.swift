//
//  PersistenceManager.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/27/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    
    private init() {}
    
    static let shared = PersistenceManager()
    
    lazy var context = persistentContainer.viewContext
    
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "wowsAssistant")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                DLog("[ERROR] Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                DLog("[ERROR] Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let rlt = try context.fetch(fetchRequest) as? [T]
            return rlt ?? [T]()
            
        } catch {
            DLog("[ERROR] fail to fetch obj: \(entityName), in PersistenceManager fetch<>()")
            return [T]()
        }
    }
    
    /// delete an object based on PersistenceManager Context
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    
}

