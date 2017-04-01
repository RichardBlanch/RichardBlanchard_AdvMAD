//
//  UITableViewDataSource.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation


extension WorkoutFeedViewController {
override func numberOfSections(in tableView: UITableView) -> Int {
    guard let sections = fetchedResultsController.sections else {
        return 0
    }
    
    return sections.count
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    guard let sectionInfo = fetchedResultsController.sections?[section] else {
        return 0
    }
    
    return sectionInfo.numberOfObjects
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutFeedViewController.feedCell, for: indexPath) as! FeedCell
    cell.workout = fetchedResultsController.object(at: indexPath)
    
    
    return cell
}

override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let sectionInfo = fetchedResultsController.sections?[section]
    return sectionInfo?.name
}
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    workoutSelected = fetchedResultsController.object(at: indexPath)
    performSegue(withIdentifier: WorkoutFeedViewController.kDetailSegueIdentifier, sender: self)
    
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let workout = fetchedResultsController.object(at: indexPath)
        return (workout.aspectRatio * tableView.frame.width) + 113
    }
   
}
