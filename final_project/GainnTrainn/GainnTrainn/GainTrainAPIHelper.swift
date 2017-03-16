//
//  GainTrainAPIHelper.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData

class GainTrainAPIHelper: NSObject {
    lazy private var dataSession:URLSession = {
       let urlSessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: urlSessionConfiguration)
        return session
    }()
    private let kWorkoutPlan = "workout_plan"
    private let kMastersets = "mastersets"
    private let kExercises = "exercises"
    let workoutService = WorkoutService.sharedCellarService
    weak var delegate:WorkoutFetchDelegate?
    
    
    
    func findWorkoutsThatUserDoesNotHave(fromWorkouts workouts:[Workout]) {
        let encapsulatedFetchRequestData = self.getWhereClause(fromWorkouts: workouts)
        var endPoint = ""
        
        if encapsulatedFetchRequestData.fetchAllWorkoutsInstead == true {
            endPoint = "http://localhost:3000/api/v1/workouts"
        } else {
            endPoint = "http://localhost:3000/api/v1/workouts/findIDs?where=\(encapsulatedFetchRequestData.whereClause ?? "")"
        }
        let endPointURL = URL(string: endPoint)
        print("Endpoint is \(endPoint)")
        dataSession.dataTask(with: endPointURL!) { (data, response, error) in
            guard error == nil else {
                print("ERROR IS \(error)")
                 self.delegate?.fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts: [Workout]())
                return
            }
            guard let data = data else {
                self.delegate?.fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts: [Workout]())
                return
            }
            do {
                if let workoutData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String:AnyObject] {
                    if let workoutArray = workoutData[self.kWorkoutPlan] as? [[String:AnyObject]] {
                        var workoutsManagedArray = [Workout]()
                        for workout in workoutArray {
                            var workoutManagedObject = Workout(json: workout, workoutService: self.workoutService)
                             var masterSetManagedArray = [MasterSet]()
                            if let masterSetsDictionary = workout[self.kMastersets] as? [[String:AnyObject]] {
                                for set in masterSetsDictionary {
                                    let masterSet = MasterSet(entity: NSEntityDescription.entity(forEntityName: "MasterSet",
                                                                                                 in: self.workoutService.managedObjectContext)!,
                                                                                                 insertInto: self.workoutService.managedObjectContext)
                                    if let exercises = set[self.kExercises] as? [[String:AnyObject]] {
                                        for exerciseDictionary in exercises {
                                            let exercise = Exercise(json: exerciseDictionary, workoutService: self.workoutService)
                                            masterSet.addToExercises(exercise)
                                            
                                        }
                                    }
                                   workoutManagedObject.addToMasterSets(masterSet)
                                }
                                
                            }
                            workoutsManagedArray.append(workoutManagedObject)
                        }
                        DispatchQueue.main.async { [weak self] in
                             self?.workoutService.coreDataStack.saveContext()
                            self?.delegate?.fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts: workoutsManagedArray)
                        }
                       
                        
                    }
                }
                 self.delegate?.fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts: [Workout]())
            } catch let error as Error {
                self.delegate?.fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts: [Workout]())
                print("Error is \(error)")
            }
            
        }.resume()
    }
    private func getWhereClause(fromWorkouts workouts:[Workout])->(whereClause:String?,fetchAllWorkoutsInstead:Bool) {
        let ids = workouts.map {$0.workoutId}
        var whereClause = ""
        for i in 0..<ids.count {
            if i == ids.count - 1 {
                whereClause += "id != \(ids[i] )"
            } else {
                whereClause += "id != \(ids[i])"
                whereClause += " "
                whereClause += "AND"
                whereClause += " "
            }
            
        }
        guard whereClause != "" else {
            return (whereClause:nil,fetchAllWorkoutsInstead:true)
        }
        whereClause = whereClause.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return (whereClause:whereClause,fetchAllWorkoutsInstead:false)
    }
}
