//
//  GainTrained
//
//  Created by Rich Blanchard on 12/22/16.
//  Copyright © 2016 Rich. All rights reserved.
//

import Foundation
import CoreData


open class CoreDataStack {
    
    let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    public lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    public lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public func newDerivedContext() -> NSManagedObjectContext {
        let context = storeContainer.newBackgroundContext()
        return context
    }
    
    public func saveContext() {
        saveContext(mainContext)
    }
    
    public func saveContext(_ context: NSManagedObjectContext) {
        if context !== mainContext {
            saveDerivedContext(context)
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    public func saveDerivedContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self.saveContext(self.mainContext)
        }
    }
}
