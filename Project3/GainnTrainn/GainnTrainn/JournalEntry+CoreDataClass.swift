//
//  JournalEntry+CoreDataClass.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 5/4/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


public class JournalEntry: NSManagedObject {
    public var journalExercises:Array<JournalExercise> {
        let journalSets = journalExercise as! Set<JournalExercise>
        return Array(journalSets) as Array<JournalExercise>
    }
    
    class func findOrCreateJournalEntry(inContext context:NSManagedObjectContext, fromWeightInputs weightInputs:Array<Array<String>>, withID id:Int16, withTitle title:String, andCreator creator:String, andWorkoutNames workoutNames:Array<String>)throws -> JournalEntry {
        let request:NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %d",#keyPath(JournalEntry.id), id)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Workout.findOrCreateWorkout -- database inconsistency")
                return matches[0]
            }
            
        }catch {
            throw error
        }
        
        let journalEntry = JournalEntry(context: context)
        journalEntry.date = NSDate()
        journalEntry.name = title
        journalEntry.creator = creator
        journalEntry.id = id
        
        
        var i = 0
        let arrayOfweightInputs = weightInputs
        for weightInputs in arrayOfweightInputs {
            let journalExerciseOne = JournalExercise(context: context)
            journalExerciseOne.name = workoutNames[i]
            i += 1
            
            var a = 0
            for weightInput in weightInputs {
                let journalRepOne = JournalReps(context: context)
                journalRepOne.setNumber = Int16(a)
                let journalSetOne = JournalSets(context: context)
                let weight = weightInput.components(separatedBy: " ")[0] ?? weightInput
                journalSetOne.weight = Int16(weight) ?? Int16.min
                
                journalExerciseOne.addToJournalReps(journalRepOne)
                journalExerciseOne.addToJournalSets(journalSetOne)
                
                journalEntry.addToJournalExercise(journalExerciseOne)
                a += 1
            }
        }
        
        return journalEntry
    }
    class func findIDForJournalEntry()throws ->Int16 {
        let fetchRequest:NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        do {
            let count = try  CoreDataStack.shared.persistentContainer.viewContext.count(for: fetchRequest)
            return Int16(count + 1)
        } catch {
            assert(true == false, "Error finding Count \(error.localizedDescription)")
            throw error
        }
       
    }

}
