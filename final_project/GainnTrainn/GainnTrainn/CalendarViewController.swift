//
//  CalendarViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/9/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import JTCalendar
import EventKit
import DZNEmptyDataSet
import CoreData

class CalendarViewController: UIViewController {
    
    var container:NSPersistentContainer? = CoreDataStack.shared.persistentContainer
    var datesForWorkout:Dictionary<String,Array<Date>>!
    lazy var dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy";
        return dateFormatter
        
    }()
    var workoutsForDate = [Workout]() {
        willSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    fileprivate let cellIdentifier = "workoutForDate"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: JTVerticalCalendarView!
    @IBOutlet weak var calendarMenu: JTCalendarMenuView!
    var calendarManager:JTCalendarManager!
    fileprivate var dateSelected:Date?
    @IBOutlet weak var dayView: JTCalendarWeekDayView!
    var workoutSelected:Workout!
    private let unwindSegue = "goToDetailWorkout"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRandomEvents()
        
        calendarManager = JTCalendarManager()
        calendarManager.delegate = self
        calendarManager.settings.pageViewHaveWeekDaysView = false
        calendarManager.settings.pageViewNumberOfWeeks = 0
        
        dayView.manager = calendarManager
        dayView.reload()
        
        calendarManager.menuView = calendarMenu
        calendarManager.contentView = calendarView
        
        calendarManager.setDate(Date())
        
        calendarMenu.scrollView.isScrollEnabled = false
        
        getTitleOfMonth(fromCalendar: calendarManager)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == unwindSegue {
                if let cell = sender as? UITableViewCell {
                    let index = tableView.indexPath(for: cell)?.row
                    let destVC = segue.destination as! WorkoutDetailViewController
                    destVC.workoutSelected = workoutsForDate[index!]
                    
                }
                
            }
        }
    }

    @IBAction func addEventsToCalendar(_ sender: UIBarButtonItem) {
        if let dateSelected = dateSelected {
            
            
            Alerter.alertForCalendar(withTitle: "Add \(workoutSelected.name ?? "Workout")", withMessage: "Add Workout To Calendar?", fromViewController: self, forDateSelected: dateSelected, workoutToPotentiallyAdd: workoutSelected, andContainer: container!, completionHandler: {[weak self] (dateSelected) in
                if let dateSelected = dateSelected {
                    self?.workoutsForDate.append((self?.workoutSelected)!)
                    DispatchQueue.main.async {
                        self?.addEventToDictionary(forDay: dateSelected.date as! Date)
                        self?.tableView.reloadData()
                        self?.dayView.reload()
                    }
                }
            })
        }
       
   
    }
    func getTitleOfMonth(fromCalendar calendar:JTCalendarManager) {
        let components = Calendar.current.dateComponents([.month,.year], from: calendar.date())
        let monthInt = components.month
        let year = components.year ?? 2017
        navigationItem.title = getMonth(monthInt: monthInt!) + " " + String(describing: year)
    }
    func getMonth(monthInt month:Int)->String {
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "Septermber"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "'"
        }
        
    }
    
    func createRandomEvents() {
        
        var eventsByDate = Dictionary<String,Array<Date>>()
        let results = Dates.fetchDates(withCount: 30, fromContainer: container!)
        guard results.error == nil else {
            return
        }
    
        if let dates = results.dates {
            for i in 0..<dates.count {
                let date = dates[i].date
                let key = dateFormatter.string(from: date as! Date)
                if eventsByDate[key] == nil {
                    eventsByDate[key] = [Date]()
                }
                eventsByDate[key]?.append(date as! Date)
                
            }
        }
        
        datesForWorkout = eventsByDate
 
    }
 
    }


extension CalendarViewController: JTCalendarDelegate {
    func calendar(_ calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let dayVie = dayView as? JTCalendarDayView {
           dayVie.isHidden = false
            
            if dayVie.isFromAnotherMonth {
                dayVie.isHidden = true
            } else if calendarManager.dateHelper.date(Date(), isTheSameDayThan: dayVie.date) {
                dayVie.circleView.isHidden = false
                dayVie.circleView.backgroundColor = UIColor.red
                dayVie.textLabel.backgroundColor = UIColor.white
            } else if (dateSelected != nil) && (calendarManager.dateHelper.date(dateSelected, isTheSameDayThan: dayVie.date)) {
                dayVie.circleView.isHidden = true
                dayVie.dotView.backgroundColor = UIColor.red
                dayVie.textLabel.textColor = UIColor.lightGray
            } else {
                dayVie.circleView.isHidden = true
                dayVie.dotView.backgroundColor = UIColor.red
                dayVie.textLabel.textColor = UIColor.black
            }
            if haveEvent(forDay: dayVie.date) == true {
                dayVie.dotView.isHidden = false
            } else {
                dayVie.dotView.isHidden = true
            }
            
        }
        
    }
    func haveEvent(forDay date:Date)-> Bool {
         let key = dateFormatter.string(from: date)
        guard let date = datesForWorkout[key], date.count > 0 else{
            return false
        }
        return true
    }
    func addEventToDictionary(forDay date:Date) {
        let key = dateFormatter.string(from: date)
        if datesForWorkout[key] == nil {
            datesForWorkout[key] = []
        }
        datesForWorkout[key]!.append(date)
    }
   
    func calendar(_ calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        if let calendarDayView = dayView as? JTCalendarDayView {
            dateSelected = calendarDayView.date
            if let context = container?.viewContext, let dates = Dates.findDatesForCalendarDate(dateSelected!, fromContext: context).dates {
                workoutsForDate = dates.flatMap {$0.fromWorkout}
            }
            
        
            calendarDayView.circleView.transform = CGAffineTransform(a: CGAffineTransform.identity.a, b: CGAffineTransform.identity.b, c: CGAffineTransform.identity.c, d: CGAffineTransform.identity.d, tx: 0.1, ty: 0.1)
            UIView.transition(with: calendarDayView, duration: 0.3, options: UIViewAnimationOptions(rawValue: 0), animations: { 
                calendarDayView.circleView.transform = CGAffineTransform.identity
                self.calendarManager.reload()
            }, completion: nil)
            if calendarManager.settings.weekModeEnabled == true {
                return
            }
            if !calendarManager.dateHelper.date(calendarDayView.date, isTheSameMonthThan: calendarView.date) {
                let order = calendarView.date.compare(calendarDayView.date)
                if order == .orderedAscending {
                    calendarView.loadNextPageWithAnimation()
                } else {
                    calendarView.loadPreviousPageWithAnimation()
                }
                
            }
            
        }
    }
    
    func calendarDidLoadNextPage(_ calendar: JTCalendarManager!) {
        getTitleOfMonth(fromCalendar: calendar)
    }
    func calendarDidLoadPreviousPage(_ calendar: JTCalendarManager!) {
        getTitleOfMonth(fromCalendar: calendar)
    }
  
}
extension CalendarViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutsForDate.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let workout = workoutsForDate[indexPath.row]
        cell.textLabel?.text = workout.name
        cell.detailTextLabel?.text = workout.bodyType
        return cell
    }
    
    
}
extension CalendarViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Workouts For This Day!", attributes: [NSForegroundColorAttributeName : UIColor.white])
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Click a Date and Hit the + To Add A Workout.", attributes: [NSForegroundColorAttributeName : UIColor.white])
    }
}


