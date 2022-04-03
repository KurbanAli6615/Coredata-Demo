//
//  PersistentStorage.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import CoreData

final class PersistentStorage {
    
    static let shared: PersistentStorage = PersistentStorage()
    
    private init() {
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Coredatademo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject <T: NSManagedObject> (managedObjext: T.Type) -> [T]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObjext.fetchRequest()) as? [T] else {
                return nil
            }
            return result
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
    
}
