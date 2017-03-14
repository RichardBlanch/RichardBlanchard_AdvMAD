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

class WorkoutService {
    
    // MARK: Properties
    static let sharedCellarService = WorkoutService() 
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    private let Workouts = "Workouts"
    
    
    // MARK: Initializers
    init() {
        self.coreDataStack = CoreDataStack(modelName: Workouts)
        self.managedObjectContext = self.coreDataStack.mainContext
    }
    func fetchWorkouts(batchSize:Int)->(workouts:[Workout]?,error:Error?) {
        do {
            let fetchRequest:NSFetchRequest<Workout> = Workout.fetchRequest()
            fetchRequest.fetchBatchSize = batchSize
            let workouts = try self.managedObjectContext.fetch(fetchRequest)
            return (workouts:workouts,error:nil)
            
        } catch let error as Error {
            return (workouts:nil,error)
        }
    }
    func fetchWorkouts(withSortDescriptors sortDescriptors:[NSSortDescriptor]?, withPredicate predicate:NSPredicate)->(workouts:[Workout]?,error:Error?) {
        do {
            let fetchRequest:NSFetchRequest<Workout> = Workout.fetchRequest()
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sortDescriptors
            let workouts = try self.managedObjectContext.fetch(fetchRequest)
            return (workouts:workouts,error:nil)
            
        } catch let error as Error {
            return (workouts:nil,error)
        }
    }
    
}
