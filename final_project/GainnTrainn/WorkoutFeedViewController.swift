//
//  WorkoutFeedViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import WatchConnectivity

class WorkoutFeedViewController: UIViewController,WCSessionDelegate {
    let workoutService = WorkoutService.sharedCellarService
    var workouts:[Workout]?
    static let feedCell = "feedCell"
    let apiHelper = GainTrainAPIHelper()
    var workoutSelected:Workout!
    static let kDetailSegueIdentifier = "workoutDetail"
     var session:WCSession?
    private static let goToFilterByViewController = "goToFilter"
    

    @IBOutlet weak var workoutTableView: UITableView!
    
 
    @IBAction func didHitFilterWorkout(_ sender: UIButton) {
        performSegue(withIdentifier: WorkoutFeedViewController.goToFilterByViewController, sender: self)
    }
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControlToTableView()
        
        let fetchWorkouts = workoutService.fetchWorkouts(batchSize: 20)
        guard fetchWorkouts.error == nil else {
            return
        }
        workouts = fetchWorkouts.workouts ?? []
        
        apiHelper.delegate = self
        
        fetchWorkoutsThatUserDoesNotHave()
        
        if WCSession.isSupported() {
            session = WCSession.default()
            session?.delegate = self
            session?.activate()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
           //self.giveMostRecentWorkoutsToWatch()
        }
    }
    func giveMostRecentWorkoutsToWatch() {
        if let session = session {
            do {
                var workoutDictionary = [[String:AnyObject]]()
                var lastFiveWorkouts = workouts?.distance(from: 0, to: 5)
                for i in 0...lastFiveWorkouts! {
                    var tempDict:[String:String] = [:]
                    let name =  workouts?[i].name
                    let bodyType = workouts?[i].bodyType
                    let creator = workouts?[i].creator
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
     apiHelper.findWorkoutsThatUserDoesNotHave(fromWorkouts: workouts!)
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
    @IBAction func returnFromFilterViewController(unwindSegue:UIStoryboardSegue) {
        
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
        guard let count = workouts?.count else {
            return 0
        }
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutFeedViewController.feedCell, for: indexPath) as! FeedCell
        cell.workout = workouts?[indexPath.row]
        cell.workoutImage = workouts?[indexPath.row].mainImage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        workoutSelected = workouts?[indexPath.row]
        performSegue(withIdentifier: WorkoutFeedViewController.kDetailSegueIdentifier, sender: self)
    }
  
}
extension WorkoutFeedViewController:WorkoutFetchDelegate {
    func fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts:[Workout]) {
        
        OperationQueue.main.addOperation { [weak self] in
            self?.workoutTableView.beginUpdates()
            for i in 0..<workouts.count {
                let indexPath = IndexPath(item: i, section: 0)
                self?.workouts?.append(workouts[i])
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
        self.workouts = dataReturned.workouts
        OperationQueue.main.addOperation { 
            self.workoutTableView.reloadData()
        }
    }
    
}

