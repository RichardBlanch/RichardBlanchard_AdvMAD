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
    
    private let kID = "id"
    private let kCreator = "creator"
    private let kName = "name"
    private let kBodyType = "body_type"
    private let kImageWidth = "img_width"
    private let kImageHeight = "img_height"
    private let kImageURL = "img_url"
    
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init(json:[String:AnyObject], workoutService:WorkoutService) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Workout", in: workoutService.managedObjectContext)
        super.init(entity: entityDescription!, insertInto: workoutService.managedObjectContext)
        self.workoutId = json[kID] as! Int32
        self.creator = json[kCreator] as? String ?? "THIS VALUE IS NIL \(self.workoutId)"
        self.name = json[kName] as! String
        self.bodyType = json[kBodyType] as? String
        self.imageWidth = json[kImageWidth] as! Int16
        self.imageHeight = json[kImageHeight] as! Int16
        self.imageURL = json[kImageURL] as? String ?? "https://www.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiit_treadmill_workouts_for_fat_loss.jpg"
        let url = URL(string: self.imageURL!)!
        do {
            let data = try Data(contentsOf: url)
            self.mainImage = UIImage(data: data)
        } catch {
            //Set UIImageHere
        }
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
