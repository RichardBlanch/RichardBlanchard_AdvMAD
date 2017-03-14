//
//  HealthKitHelper.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/19/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class EventKitHelper: NSObject {
    static let sharedHelper = EventKitHelper()
    var eventStore:EKEventStore!
    var calendar:EKCalendar!
   
    private override init() {
        super.init()
        self.eventStore = EKEventStore()
    }
    func getPermission() {
        eventStore.requestAccess(to: .event) { (bool, error) in
            if bool == true {
                self.useCalendar()
            }
        }
    }
    func useCalendar() {
       let calendarForEvents = self.eventStore.calendars(for: .event)
        self.calendar = EKCalendar(for: .event, eventStore: self.eventStore)
        self.calendar.title = "GainnTrainn"
        self.calendar.source = self.eventStore.defaultCalendarForNewEvents.source
        do {
            try self.eventStore.saveCalendar(self.calendar, commit: true)
        } catch {
            print("The error is \(error)")
        }
        
        
       let calendar = Calendar.current
       let oneDayAgoComponents = NSDateComponents()
       oneDayAgoComponents.day = 5
       let oneDayAgo = calendar.date(byAdding: oneDayAgoComponents as DateComponents, to: Date())
        
        let oneYearAgoComponents = NSDateComponents()
        oneYearAgoComponents.year = -1
        let oneYearAgo = calendar.date(byAdding: oneYearAgoComponents as DateComponents, to: Date())
        
        
        let predicate = eventStore.predicateForEvents(withStart: oneYearAgo!, end: oneDayAgo!, calendars: calendarForEvents)
        
     
    }
    func writeEventToCalendar(withTitle title:String, startDate:Date, endDate:Date, recurrenceRules:[EKRecurrenceRule]?, span:EKSpan) {
        let event = EKEvent(eventStore: self.eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.recurrenceRules = recurrenceRules
        event.calendar = self.calendar
        do {
            try self.eventStore.save(event, span: span)
        } catch {
            print("error is \(error)")
        }
        
        
    }
    
    
}






