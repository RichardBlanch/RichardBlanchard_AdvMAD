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
    func fetchWorkouts(_ batchSize:Int,withFetchOffset fetchOffset:Int, withCurrentIDs:[Int32])->(workouts:[Workout]?,error:Error?) {
        var predicates = [NSPredicate]()
        do {
            
            for identifier in withCurrentIDs {
                print("identifier is \(identifier)")
                print(#keyPath(Workout.workoutId))
                let predicate = NSPredicate(format: "%K != %@", "id", identifier)
               // predicates.append(predicate)
            }
            
            let predicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: predicates)
            let fetchRequest:NSFetchRequest<Workout> = Workout.fetchRequest()
            fetchRequest.fetchBatchSize = 3
            fetchRequest.fetchLimit = batchSize
            if predicates.count > 0 {
              //  fetchRequest.predicate = predicate
            }
            fetchRequest.fetchOffset = fetchOffset
            let workouts = try self.managedObjectContext.fetch(fetchRequest)
            return (workouts:workouts,error:nil)
            
        } catch let error  {
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
