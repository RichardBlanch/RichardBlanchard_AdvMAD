//
//  Dates+CoreDataProperties.swift
//
//
//  Created by Rich Blanchard on 3/13/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


class Dates:NSManagedObject {
   
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dates> {
        return NSFetchRequest<Dates>(entityName: "Dates");
    }
    
    @NSManaged public var date: NSDate?
    @NSManaged public var fromWorkout: Workout?
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init(date:NSDate,workout:Workout,workoutService:WorkoutService) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Dates", in: workoutService.managedObjectContext)
        super.init(entity: entityDescription!, insertInto: workoutService.managedObjectContext)
        self.date = date as NSDate?
        self.fromWorkout = workout
    }
    class func findDatesForCalendarDate(date:Date)->(dates:[Dates]?,error:Error?) {
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // Get today's beginning & end
        let dateFrom:NSDate = calendar.startOfDay(for: date) as NSDate // eg. 2016-10-10 00:00:00
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom as Date)
        components.day! += 1
        let dateTo:NSDate = calendar.date(from: components)! as NSDate  // eg. 2016-10-11 00:00:00
       
        let predOne = NSPredicate(format: "%K >= %@", #keyPath(Dates.date), dateFrom)
        let predTwo = NSPredicate(format: "%K <= %@", #keyPath(Dates.date), dateTo)
        let predicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predOne,predTwo])
    
        let fetchRequest:NSFetchRequest<Dates> = Dates.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            let results = try WorkoutService.sharedCellarService.managedObjectContext.fetch(fetchRequest)
            return (results,nil)
        }catch {
            return (nil,error)
        }
    }
    class func fetchDates(withCount count:Int)->(dates:[Dates]?,error:Error?) {
        let fetchRequest:NSFetchRequest<Dates> = Dates.fetchRequest()
        fetchRequest.fetchBatchSize = count
        let oldest = NSSortDescriptor(key: #keyPath(Dates.date), ascending: true)
        fetchRequest.sortDescriptors = [oldest]
        do {
            let results = try WorkoutService.sharedCellarService.managedObjectContext.fetch(fetchRequest)
            return (results,nil)
            
        } catch {
            return (nil,error)
        }
        
    }
    
}
