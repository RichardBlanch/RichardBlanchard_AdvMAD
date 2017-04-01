
public class Request: NSObject {
    lazy private var dataSession:URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: urlSessionConfiguration)
        return session
    }()
    private let kWorkoutPlan = "workout_plan"
    private let kMastersets = "mastersets"
    private let kExercises = "exercises"
    
    
    
    
    public func findWorkoutsThatUserDoesNotHave(fromWorkouts workoutIDs:[Int32],completionHandler:@escaping(_ workouts:[Workout]?)->Void) {
        let encapsulatedFetchRequestData = self.getWhereClause(fromWorkouts: workoutIDs)
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
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let workoutData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String:AnyObject] {
                    if let workoutArray = workoutData[self.kWorkoutPlan] as? [[String:AnyObject]] {
                        var workoutsManagedArray = [Workout]()
                        for workoutJSON in workoutArray {
                            let workout = Workout(json: workoutJSON)
                            var masterSetArray = [MasterSet]()
                            if let masterSetsDictionary = workoutJSON[self.kMastersets] as? [[String:AnyObject]] {
                                for set in masterSetsDictionary {
                                    let masterSet = MasterSet()
                                    if let exercises = set[self.kExercises] as? [[String:AnyObject]] {
                                        masterSet.exercises = []
                                        for exerciseDictionary in exercises {
                                            let exercise = Exercise(json: exerciseDictionary)
                                            masterSet.exercises?.append(exercise)
                                        }
                                        masterSetArray.append(masterSet)
                                    }
                                    workout.masterSets = masterSetArray
                                }
                                
                            }
                            workoutsManagedArray.append(workout)
                        }
                        DispatchQueue.main.async {
                            completionHandler(workoutsManagedArray)
                        }
                    }
                }
            } catch let error as Error {
                print("Error is \(error)")
            }
            
            }.resume()
    }
    private func getWhereClause(fromWorkouts workouts:[Int32])->(whereClause:String?,fetchAllWorkoutsInstead:Bool) {
        var whereClause = ""
        for i in 0..<workouts.count {
            if i == workouts.count - 1 {
                whereClause += "id != \(workouts[i] )"
            } else {
                whereClause += "id != \(workouts[i])"
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
