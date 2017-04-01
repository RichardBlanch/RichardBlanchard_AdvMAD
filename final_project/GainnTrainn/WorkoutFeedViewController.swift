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



class WorkoutFeedViewController: FetchedResultsTableViewController {
    
    // MARK: - Properties
   
    var fetchedResultsController : NSFetchedResultsController<Workout>!
     static let feedCell = "feedCell"
    static let kDetailSegueIdentifier = "workoutDetail"
    fileprivate static let goToFilterByViewController = "goToFilter"
    var workoutSelected:Workout!
    let request = APIForGainTrain.Request()
    var container: NSPersistentContainer? = CoreDataStack.shared.persistentContainer {
        didSet {
            updateUI()
        }
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    func updateUI() {
        if let context = container?.viewContext {
            let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Workout.bodyType), ascending: true),NSSortDescriptor(key: #keyPath(Workout.name), ascending: true)]
            fetchRequest.fetchBatchSize = 5
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: #keyPath(Workout.bodyType),
                                                                  cacheName: nil)
            
            fetchedResultsController.delegate = self
            
            do {
                try fetchedResultsController.performFetch()
                tableView.reloadData()
                if let workouts = fetchedResultsController.fetchedObjects {
                    request.findWorkoutsThatUserDoesNotHave(fromWorkouts: ((workouts.count == 0) ? [] : workouts.flatMap {$0.workoutId}), completionHandler: {[weak self] (newWorkouts) in
                        if let newWorkouts = newWorkouts {
                            context.perform {
                                for newWorkout in newWorkouts {
                                    let _ = try? Workout.findOrCreateWorkout(matching: newWorkout, in: context)
                                }
                                try? context.save()
                            }
                           
                        }
                    })
                    
                }
            } catch let error as NSError {
                print("Fetching error: \(error), \(error.userInfo)")
            }
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


extension WorkoutFeedViewController: FilterWorkoutsDelegate {
    func wantsToFetchWorkoutsWith(withFilterArray filterArray:[String]) {
        let newPredicate = Workout.fetchPredicate(fromFilterArray: filterArray)
        fetchedResultsController.fetchRequest.predicate = newPredicate
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("errror is \(error)")
        }
    }
    
}
