//
//  Alerter.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import EventKit

struct Alerter {
    static func alertForCalendar(withTitle title:String, withMessage message:String, fromViewController viewController:UIViewController, forDateSelected dateSelected:Date,workoutToPotentiallyAdd workout:Workout, completionHandler:@escaping (_ date:(Dates)?)->Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let add = UIAlertAction(title: "Add!", style: .default) { (action) in
            
            EventKitHelper.sharedHelper.writeEventToCalendar(withTitle: title, startDate: dateSelected, endDate: dateSelected, recurrenceRules: nil, span: EKSpan(rawValue: 0)!)
            
            let date = Dates(date: dateSelected as NSDate , workout: workout, workoutService: WorkoutService.sharedCellarService)
            workout.addDate(date)
            completionHandler(date)
            
            do {
                try WorkoutService.sharedCellarService.managedObjectContext.save()
            } catch {
               completionHandler(nil)
            }
            
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(add)
        alertController.addAction(cancel)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
