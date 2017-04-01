//
//  Workout+CoreDataProperties.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import APIForGainTrain


open class Workout:NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout");
    }
    
    @NSManaged public var workoutId: Int32
    @NSManaged public var creator: String?
    @NSManaged public var name: String?
    @NSManaged public var bodyType: String?
    @NSManaged public var imageWidth: Int16
    @NSManaged public var imageHeight: Int16
    @NSManaged public var imageURL: String?
    @NSManaged public var mainImage: UIImage?
    @NSManaged public var masterSets: NSSet?
    @NSManaged public var forDates: NSSet?
    @NSManaged public var journal: Journal?
    
    var masterSetsAsArray: [MasterSet]? {
        get {
            if let masterSet = masterSets {
                return Array(masterSet) as! [MasterSet]
            }
            return nil
        }
    }
    var aspectRatio:CGFloat {
        return CGFloat(CGFloat(imageHeight) / CGFloat(imageWidth))
    }
    
    
    
    
    func getSetName(forCount count:Int)->String {
        switch count {
        case 1: return "Single-Set"
        case 2: return "Super-Set"
        case 3: return "Tri-Set"
        case 4: return "Quad-Set"
        default: return "Cycle"
        }
    }
    class func getStaticImagesAndTextForCollectionView()->[(UIImage,String)]! {
        var tupleArray = [(UIImage,String)]()
        tupleArray = [(workoutImage:UIImage(named: "GainTrainBack")!, workoutBodyType: "Back") , (workoutImage:UIImage(named: "GainTrainCardio")!, workoutBodyType: "Cardio"),(workoutImage:UIImage(named: "GainTrainChest")!, workoutBodyType: "Chest"), (workoutImage:UIImage(named: "GainTrainLegs")!, workoutBodyType: "Legs") ]
       
        return tupleArray
    }
    class func fetchPredicate(fromFilterArray array:[String])->NSCompoundPredicate? {
        var predicate = NSCompoundPredicate()
        var predicates = [NSPredicate]()
        if array.count == 0 {
            return nil
        }
        for filterItem in array {
            var pred = NSPredicate(format: "%K LIKE %@", #keyPath(Workout.bodyType), "*\(filterItem)*")
            predicates.append(pred)
        }
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
    class func findOrCreateWorkout(matching workout: APIForGainTrain.Workout, in context: NSManagedObjectContext) throws -> Workout
    {
        let request:NSFetchRequest<Workout> = Workout.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %d",#keyPath(Workout.workoutId), workout.workoutId)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                 assert(matches.count == 1, "Workout.findOrCreateWorkout -- database inconsistency")
                return matches[0]
            }
            
        }catch {
            throw error
        }
        let coreDataWorkout = Workout(context: context)
        coreDataWorkout.workoutId = workout.workoutId
        coreDataWorkout.name = workout.name
        coreDataWorkout.bodyType = workout.bodyType
        coreDataWorkout.creator = workout.creator
        coreDataWorkout.imageHeight = workout.imageHeight
        coreDataWorkout.imageWidth = workout.imageWidth
        coreDataWorkout.imageURL = workout.imageURL
        if let data = try? Data(contentsOf: (URL(string: (workout.imageURL)!)!)) {
            let mainImage = UIImage(data: data)
            coreDataWorkout.mainImage = mainImage
        }
        
        if let sets = workout.masterSets {
            for set in sets {
                let coreDataSet = MasterSet(context: context)
                if let exercises = set.exercises {
                    for exercise in exercises {
                        let coreDataExercise = Exercise(context: context)
                        coreDataExercise.name = exercise.name
                        coreDataExercise.reps = exercise.reps
                        coreDataExercise.sets = exercise.sets
                        coreDataExercise.masterSet = coreDataSet
                        coreDataSet.addToExercises(coreDataExercise)
                    }
                }
                coreDataWorkout.addToMasterSets(coreDataSet)
            }
        }
       
        return coreDataWorkout
    }
}

// MARK: Generated accessors for masterSets
extension Workout {

    @objc(addMasterSetsObject:)
    @NSManaged public func addToMasterSets(_ value: MasterSet)

    @objc(removeMasterSetsObject:)
    @NSManaged public func removeFromMasterSets(_ value: MasterSet)

    @objc(addMasterSets:)
    @NSManaged public func addToMasterSets(_ values: NSSet)

    @objc(removeMasterSets:)
    @NSManaged public func removeFromMasterSets(_ values: NSSet)
    
    //////////////////////////////////////////////////////////////////
    
    func addDate(_ date:Dates) {
        var dates = self.mutableSetValue(forKey: #keyPath(Workout.forDates))
        dates.add(date)
    }
    
    
    @objc(addDatessObject:)
    @NSManaged func addToDates(_ value: Dates)
    
    @objc(removeDatesObject:)
    @NSManaged func removeFromDates(_ value: Dates)
    
    @objc(addDates:)
    @NSManaged public func addToDates(_ values: NSSet)
    
    @objc(removeDates:)
    @NSManaged public func removeFromDates(_ values: NSSet)

}
extension Workout {
    override open var description: String {
        return self.name ?? "Nil name"
    }
}
