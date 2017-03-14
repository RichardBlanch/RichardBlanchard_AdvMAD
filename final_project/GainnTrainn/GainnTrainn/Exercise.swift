//
//  Exercise+CoreDataProperties.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


open class Exercise:NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise");
    }

    @NSManaged public var reps: String?
    @NSManaged public var sets: String?
    @NSManaged public var name: String?
    @NSManaged public var masterSet: MasterSet?
    
    private let kReps = "reps"
    private let kSets = "sets"
    private let kName = "name"
    
   
    
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init(json:[String:AnyObject],workoutService:WorkoutService) {
         let entityDescription = NSEntityDescription.entity(forEntityName: "Exercise", in: workoutService.managedObjectContext)
        super.init(entity: entityDescription!, insertInto: workoutService.managedObjectContext)
        self.reps = json[kReps] as! String
        self.name = json[kName] as? String ?? "THIS VALUE IS NIL"
        self.sets = json[kSets] as! String
        
    }

}
