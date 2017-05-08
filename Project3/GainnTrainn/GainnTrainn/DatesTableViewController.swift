//
//  DatesTableViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreData
import DZNEmptyDataSet

enum SegmentIndexSelected {
    case Journal, Workout
    
    static func getJournalOrWorkout(fromSegment segmentControl:UISegmentedControl)->SegmentIndexSelected {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return .Journal
        default:
            return .Workout
        }
    }
}

class DatesTableViewController: FetchedResultsTableViewController {
    var fetchedResultsViewController:NSFetchedResultsController<Dates>!
    var journalFetchedResultsController:NSFetchedResultsController<JournalEntry>!
    var container:NSPersistentContainer? = CoreDataStack.shared.persistentContainer {didSet {updateUI()}}
    private let cellIdentifier = "Cell"
    private let goToJournalIdentifier = "goToJournal"
    
    lazy var dateFormatter:DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .full
       dateFormatter.timeStyle = .none
       return dateFormatter
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
   
    @IBAction func unwindSegueFromJournal(_ storyboardSegue:UIStoryboardSegue) {
        if storyboardSegue.identifier == "unwindToJournal" {
            segmentControl.selectedSegmentIndex = 0
            updateUI()
        }
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        updateUI()
    }
    override func viewDidLoad() {
        updateUI()
    }
    func updateUI() {
        if let context = container?.viewContext {
            let index = SegmentIndexSelected.getJournalOrWorkout(fromSegment: segmentControl)
            if index == .Workout {
                fetchedResultsViewController = NSFetchedResultsController(fetchRequest: Dates.fetchDatesWithin(ofDate: Date()), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                
                 try! fetchedResultsViewController.performFetch()
                
            } else {
                let journalEntryFetchFequest:NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
                journalEntryFetchFequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(JournalEntry.id), ascending: true)]
                
                journalFetchedResultsController = NSFetchedResultsController(fetchRequest: journalEntryFetchFequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                
                 try! journalFetchedResultsController.performFetch()
            }
            
           
            tableView.reloadData()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == goToJournalIdentifier, let indexPath = tableView.indexPath(for: sender as! UITableViewCell)  {
                    let index = SegmentIndexSelected.getJournalOrWorkout(fromSegment: segmentControl)
                    let journalViewController = segue.destination.contents as! JournalViewController
                    let workout:Workout
                    let journalEntry:JournalEntry
                    if index == .Workout {
                         workout = fetchedResultsViewController.object(at: indexPath).fromWorkout!
                        journalViewController.workout = workout
                    } else {
                        journalViewController.journalEntry = journalFetchedResultsController.object(at: indexPath)
                    }
                
                
                
            }
        }
    }
    //MARK: - TableViewDelegate + Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        let index = SegmentIndexSelected.getJournalOrWorkout(fromSegment: segmentControl)
        if index == .Workout {
            guard let sections = fetchedResultsViewController.sections else {
                return 0
            }
            
            return sections.count
        } else {
            guard let sections = journalFetchedResultsController.sections else {
                return 0
            }
            
            return sections.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let index = SegmentIndexSelected.getJournalOrWorkout(fromSegment: segmentControl)
        if index == .Workout {
            guard let sectionInfo = fetchedResultsViewController.sections?[section] else {
                return 0
            }
            
            return sectionInfo.numberOfObjects
        } else {
            guard let sectionInfo = journalFetchedResultsController.sections?[section] else {
                return 0
            }
            
            return sectionInfo.numberOfObjects
        }
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = SegmentIndexSelected.getJournalOrWorkout(fromSegment: segmentControl)
        if index == .Workout {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let date = fetchedResultsViewController.object(at: indexPath)
            let string = dateFormatter.string(from: date.date as! Date)
            let workout = date.fromWorkout
            cell.textLabel?.text = (workout?.name)!
            cell.detailTextLabel?.text = string
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let workout = journalFetchedResultsController.object(at: indexPath)
            cell.textLabel?.text = (workout.name)!
            cell.detailTextLabel?.text = dateFormatter.string(from: workout.date as! Date)
            return cell
        }
    }
}
extension DatesTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let journalViewController = secondaryViewController.contents as? JournalViewController, journalViewController.workout == nil {
                return true //don't want this to happen kind of faking out
            } else {
                return false
            }
        }
        return false
    }
}
extension DatesTableViewController:DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Train")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "You Have Not Added Any Workouts To Your Journal", attributes: nil)
    }
    
}
