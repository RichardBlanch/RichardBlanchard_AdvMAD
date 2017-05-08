//
//  MasterSet+CoreDataProperties.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


open class MasterSet:NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MasterSet> {
        return NSFetchRequest<MasterSet>(entityName: "MasterSet");
    }

    @NSManaged public var workout: Workout?
    @NSManaged public var exercises: NSSet?
    var exercisesAsArray: [Exercise]? {
        get {
            if let exercise = exercises {
                return Array(exercise) as! [Exercise]
            }
            return nil
        }
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}

// MARK: Generated accessors for exercises
extension MasterSet {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
