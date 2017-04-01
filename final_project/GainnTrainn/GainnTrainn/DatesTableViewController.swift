//
//  DatesTableViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreData

class DatesTableViewController: FetchedResultsTableViewController {
    var fetchedResultsViewController:NSFetchedResultsController<Dates>!
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
    
    override func viewDidLoad() {
        updateUI()
    }
    func updateUI() {
        if let context = container?.viewContext {
            fetchedResultsViewController = NSFetchedResultsController(fetchRequest: Dates.fetchDatesWithin(ofDate: Date()), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try! fetchedResultsViewController.performFetch()
            tableView.reloadData()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == goToJournalIdentifier, let indexPath = tableView.indexPath(for: sender as! UITableViewCell)  {
                    let workout = fetchedResultsViewController.object(at: indexPath).fromWorkout
                    let journalViewController = segue.destination.contents as! JournalViewController
                    journalViewController.workout = workout
            }
        }
    }
    //MARK: - TableViewDelegate + Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsViewController.sections else {
            return 0
        }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchedResultsViewController.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let date = fetchedResultsViewController.object(at: indexPath)
        let string = dateFormatter.string(from: date.date as! Date)
        let workout = date.fromWorkout
        cell.textLabel?.text = (workout?.name)! 
        cell.detailTextLabel?.text = string
        return cell
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
