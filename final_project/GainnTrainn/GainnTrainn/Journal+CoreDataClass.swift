//
//  Journal+CoreDataClass.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/22/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


public class Journal: NSManagedObject {
    class func addToJournal(fromContext context:NSManagedObjectContext, withWorkout workout:Workout)throws -> Journal {
        do {
            let request:NSFetchRequest<Journal> = Journal.fetchRequest()
            do {
                let result = try context.fetch(request)
                assert(result.count <= 1, "More than one journal")
                result[0].addToWorkouts(workout)
                return result[0]
                
            }catch {
             throw error
            }
        }
        let journal = Journal(context: context)
        journal.addToWorkouts(workout)
        return journal
    }

}
