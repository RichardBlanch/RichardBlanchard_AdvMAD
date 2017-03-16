//
//  WorkoutService.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

import Foundation
import CoreData

class ArtistService {
    
    // MARK: Properties
    static let sharedCellarService = ArtistService()
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    private let Music = "Music"
    
    
    // MARK: Initializers
    private init() {
        self.coreDataStack = CoreDataStack(modelName: Music)
        self.managedObjectContext = self.coreDataStack.mainContext
    }

    
}
