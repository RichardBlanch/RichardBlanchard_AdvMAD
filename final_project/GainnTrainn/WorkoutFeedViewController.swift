//
//  WorkoutFeedViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import WatchConnectivity
import APIForGainTrain


import UIKit
import CoreData



class WorkoutFeedViewController: UIViewController {
    
    // MARK: - Properties
    var coreDataStack: CoreDataStack!
    var fetchedResultsController : NSFetchedResultsController<Workout>!
     static let feedCell = "feedCell"
    let apiHelper = GainTrainAPIHelper()
    static let kDetailSegueIdentifier = "workoutDetail"
    fileprivate static let goToFilterByViewController = "goToFilter"
    var workoutSelected:Workout!
    let request = APIForGainTrain.Request()
    
    
     var predicate:NSPredicate?  {
        if let workouts = (self.fetchedResultsController?.fetchedObjects) {
            let predicate = NSPredicate(format: "NOT (self in %@)", workouts)
            return predicate
        }
        return nil
    }
 
    
    
   
    @IBOutlet weak var addButton: UIBarButtonItem!
    
     @IBOutlet weak var workoutTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       workoutTableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Workout.bodyType), ascending: true),NSSortDescriptor(key: #keyPath(Workout.name), ascending: true)]
        fetchRequest.fetchBatchSize = 5
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: WorkoutService.sharedCellarService.coreDataStack.mainContext,
                                                              sectionNameKeyPath: #keyPath(Workout.bodyType),
                                                              cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            workoutTableView.reloadData()
            if let workouts = fetchedResultsController.fetchedObjects {
                if workouts.count == 0 {
                    request.findWorkoutsThatUserDoesNotHave(fromWorkouts: [])
                } else {
                    request.findWorkoutsThatUserDoesNotHave(fromWorkouts: workouts.flatMap {$0.workoutId})
                }
            }
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WorkoutFeedViewController.kDetailSegueIdentifier {
            let destVC = segue.destination as! WorkoutDetailViewController
            destVC.workoutSelected = workoutSelected
        } else if segue.identifier == WorkoutFeedViewController.goToFilterByViewController {
            let navigationController = segue.destination as! UINavigationController
            let filterByViewController = navigationController.topViewController as! FilterViewController
            filterByViewController.delegate = self
        }
    }
    
}



// MARK: - IBActions
extension WorkoutFeedViewController {
    @IBAction func returnFromFilterViewController(unwindSegue:UIStoryboardSegue) {
        
    }
    @IBAction func didHitFilterWorkout(_ sender: UIButton) {
        DispatchQueue.main.async {[weak self] in
            self?.performSegue(withIdentifier: WorkoutFeedViewController.goToFilterByViewController, sender: self)
        }
    }
}


// MARK: - NSFetchedResultsControllerDelegate
extension WorkoutFeedViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        workoutTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            workoutTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            workoutTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            if let cell = workoutTableView.cellForRow(at: indexPath!) as? FeedCell {
                //configure(cell: cell, for: indexPath!)
            }
            
        case .move:
            workoutTableView.deleteRows(at: [indexPath!], with: .automatic)
            workoutTableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        workoutTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            workoutTableView.insertSections(indexSet, with: .automatic)
        case .delete:
            workoutTableView.deleteSections(indexSet, with: .automatic)
        default: break
        }
    }
}

extension WorkoutFeedViewController: FilterWorkoutsDelegate {
    func wantsToFetchWorkoutsWith(withFilterArray filterArray:[String]) {
        let newPredicate = Workout.fetchPredicate(fromFilterArray: filterArray)
        //NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: "workouts")
        fetchedResultsController.fetchRequest.predicate = newPredicate
        do {
            try fetchedResultsController.performFetch()
            workoutTableView.reloadData()
        } catch {
            print("errror is \(error)")
        }
    }
    
}







/*
class WorkoutFeedViewController: UIViewController,WCSessionDelegate {
    let workoutService = WorkoutService.sharedCellarService
    var workouts:[Workout] = []
    static let feedCell = "feedCell"
    let apiHelper = GainTrainAPIHelper()
    var workoutSelected:Workout!
    static let kDetailSegueIdentifier = "workoutDetail"
     var session:WCSession?
    private static let goToFilterByViewController = "goToFilter"
    fileprivate var heightOfSelectedImageView:CGFloat!
    

    @IBOutlet weak var workoutTableView: UITableView!
    
 
    @IBAction func didHitFilterWorkout(_ sender: UIButton) {
        performSegue(withIdentifier: WorkoutFeedViewController.goToFilterByViewController, sender: self)
    }
  
   
    func add(newWorkouts workouts:[Workout], atTop top:Bool) {
        let countBeforeAdding = self.workouts.count - 1
        DispatchQueue.main.async { [weak self] in
            self?.workoutTableView.beginUpdates()
            for i in 0..<workouts.count {
                let insertSpot =  (top == true) ? i : (i + countBeforeAdding)
                let insertStyle =  (top == true) ? UITableViewRowAnimation.top : (.bottom)
                let indexPath = IndexPath(item: insertSpot, section: 0)
                self?.workouts.insert(workouts[i], at: insertSpot)
                self?.workoutTableView.insertRows(at: [indexPath], with: insertStyle)
            }
            self?.workoutTableView.endUpdates()
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControlToTableView()
        
        let fetchWorkouts = workoutService.fetchWorkouts(3, withFetchOffset: 0, withCurrentIDs: [])
        guard fetchWorkouts.error == nil else {
            return
        }
        add(newWorkouts: fetchWorkouts.workouts!, atTop: true)
       
        
        apiHelper.delegate = self
        
        //fetchWorkoutsThatUserDoesNotHave()
        /*
        if WCSession.isSupported() {
            session = WCSession.default()
            session?.delegate = self
            session?.activate()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
           //self.giveMostRecentWorkoutsToWatch()
        }
 */
    }
    func giveMostRecentWorkoutsToWatch() {
        if let session = session {
            do {
                var workoutDictionary = [[String:AnyObject]]()
                var lastFiveWorkouts = workouts.distance(from: 0, to: 5)
                for i in 0...lastFiveWorkouts {
                    var tempDict:[String:String] = [:]
                    let name =  workouts[i].name
                    let bodyType = workouts[i].bodyType
                    let creator = workouts[i].creator
                    tempDict["name"] = name
                    tempDict["bodyType"] = bodyType
                    tempDict["creator"] = creator
                    workoutDictionary.append(tempDict as [String : AnyObject])
                }
                
                try session.updateApplicationContext(["workouts":workoutDictionary])
            }catch {
                print("error is \(error)")
            }
        }
        
    }
    func fetchWorkoutsThatUserDoesNotHave() {
     apiHelper.findWorkoutsThatUserDoesNotHave(fromWorkouts: workouts)
    }
    func addRefreshControlToTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchWorkoutsThatUserDoesNotHave), for: .valueChanged)
        workoutTableView.refreshControl = refreshControl
    }
     //MARK: -- Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WorkoutFeedViewController.kDetailSegueIdentifier {
            let workoutDetailViewController = segue.destination as! WorkoutDetailViewController
            workoutDetailViewController.workoutSelected = workoutSelected
        } else if segue.identifier == WorkoutFeedViewController.goToFilterByViewController {
            let navigationController = segue.destination as! UINavigationController
            let filterByViewController = navigationController.topViewController as! FilterViewController
            filterByViewController.delegate = self
        }
    }
 
    //MARK: -- WCSESSION DELEGATES
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("MESSAGE IS \(message)")
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if session.isPaired {
            do {
                try  session.updateApplicationContext(["Rich":"Blanchard"])
                print("sent")
            } catch let error as Error {
                print("error is \(error)")
            }
            
        } else {
            print("not paierd")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("inactive")
    }
    func sessionDidDeactivate(_ session: WCSession) {
        print("deactivated")
    }

}
extension WorkoutFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutFeedViewController.feedCell, for: indexPath) as! FeedCell
        cell.workout = workouts[indexPath.row]
        cell.workoutImage = workouts[indexPath.row].mainImage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        workoutSelected = workouts[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! FeedCell
        heightOfSelectedImageView = cell.mainImage.bounds.height
        performSegue(withIdentifier: WorkoutFeedViewController.kDetailSegueIdentifier, sender: self)
    }
  
}
extension WorkoutFeedViewController:WorkoutFetchDelegate {
    func fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts:[Workout]) {
        
        OperationQueue.main.addOperation { [weak self] in
            self?.workoutTableView.beginUpdates()
            for i in 0..<workouts.count {
                let indexPath = IndexPath(item: i, section: 0)
                self?.workouts.append(workouts[i])
                self?.workoutTableView.insertRows(at: [indexPath], with: .top)
            }
            self?.workoutTableView.endUpdates()
            self?.workoutTableView.refreshControl?.endRefreshing()
        }
    }
}
extension WorkoutFeedViewController: FilterWorkoutsDelegate {
    func wantsToFetchWorkoutsWith(withFilterArray filterArray:[String]) {
        guard filterArray.count > 0 else {
            return
        }
        let predicate = Workout.fetchPredicate(fromFilterArray: filterArray)
        let dataReturned = WorkoutService.sharedCellarService.fetchWorkouts(withSortDescriptors: nil, withPredicate: predicate)
        guard dataReturned.error == nil else {
            return
        }
        self.workouts = dataReturned.workouts!
        OperationQueue.main.addOperation { 
            self.workoutTableView.reloadData()
        }
    }
    
}
extension WorkoutFeedViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        if y > h - 20 && offset.y >= 0 {
            let ids:[Int32] = (workouts.flatMap {$0.workoutId})
            
            let fetchWorkouts = workoutService.fetchWorkouts(3, withFetchOffset: (workouts.count) - 1, withCurrentIDs: ids)
            guard fetchWorkouts.error == nil else {
                return
            }
            if let workouts = fetchWorkouts.workouts {
                add(newWorkouts: workouts, atTop: false)
            }
            
        }
    }
}
*/
