//
//  Alerter.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import EventKit
import CoreData

struct Alerter {
    
    static func alertForCalendar(withTitle title:String, withMessage message:String, fromViewController viewController:UIViewController, forDateSelected dateSelected:Date,workoutToPotentiallyAdd workout:Workout, andContainer container:NSPersistentContainer, completionHandler:@escaping (_ date:(Dates)?)->Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let add = UIAlertAction(title: "Add!", style: .default) { (action) in
            
            EventKitHelper.sharedHelper.writeEventToCalendar(withTitle: title, startDate: dateSelected, endDate: dateSelected, recurrenceRules: nil, span: EKSpan(rawValue: 0)!)
            
            container.viewContext.perform {
                let date = Dates(context: container.viewContext)
                date.date = dateSelected as NSDate
                date.fromWorkout = workout
                workout.addDate(date)
                completionHandler(date)
                do {
                    try  container.viewContext.save()
                } catch {
                    completionHandler(nil)
                }
            }
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(add)
        alertController.addAction(cancel)
        viewController.present(alertController, animated: true, completion: nil)
    }
    static func giveAlertForJournal(withTitle title:String, withMessage message:String, fromViewController viewController:UIViewController, andContext context:NSManagedObjectContext) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Add Anyway", style: .default) { (action) in
            context.perform {
                do {
                    //TODO - ADD WORKOUT HERE.
                    fatalError("Implement TODO above pass completion handler back in closure and call add journal method")
                   // let _ = try Journal.addToJournal(fromContext: context, withWorkout: workout)
                } catch {
                    fatalError("Error adding Journal Entry -- error is \(error.localizedDescription)")
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(ok)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    static func giveAlertForMissingInput(withTitle title:String, withMessage message: String, fromViewController viewController:UIViewController, withContext context:NSManagedObjectContext, andWorkout workout:Workout) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Add Anyway", style: .default) { (action) in
            context.perform {
                do {
                    let _ = try Journal.addToJournal(fromContext: context, withWorkout: workout)
                } catch {
                    fatalError("Error adding Journal Entry -- error is \(error.localizedDescription)")
                }
            }
        }
        let cancel = UIAlertAction(title: "Do Not Add", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(ok)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
 
}
