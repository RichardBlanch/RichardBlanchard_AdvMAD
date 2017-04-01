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
    
    

}
