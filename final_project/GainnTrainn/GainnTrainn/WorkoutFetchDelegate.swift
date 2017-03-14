//
//  WorkoutFetchDelegate.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData

protocol WorkoutFetchDelegate:NSObjectProtocol {
    func fetchedWorkoutsWithIDsThatCoreDataDidNotHave(workouts:[Workout])
}
protocol FilterWorkoutsDelegate:NSObjectProtocol {
    func wantsToFetchWorkoutsWith(withFilterArray filterArray:[String])
}

