//
//  Journal+CoreDataProperties.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/22/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal");
    }

    @NSManaged public var workouts: NSSet?

}

// MARK: Generated accessors for workouts
extension Journal {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: Workout)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: Workout)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}
