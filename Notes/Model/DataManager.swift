//
//  DataManager.swift
//  Notes
//
//  Created by Jinwook Huh on 2022/01/21.
//

import CoreData
import Foundation

class DataManager {
    static let shared: DataManager = DataManager()
    
    private init() {}
    
    var container: NSPersistentContainer?
    
    var mainContext: NSManagedObjectContext {
        guard let context = container?.viewContext else {
            fatalError("Unable to load context")
        }
        return context
    }
    
    func setup(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        container?.loadPersistentStores(completionHandler: { _, error in
            if let error: Error = error {
                fatalError(error.localizedDescription)
            }
        })
    }
    
    func saveMainContext() {
        mainContext.perform {
            if self.mainContext.hasChanges {
                do {
                    try self.mainContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}
