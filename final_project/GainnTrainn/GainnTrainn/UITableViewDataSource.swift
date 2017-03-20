//
//  UITableViewDataSource.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation


extension WorkoutFeedViewController: UITableViewDelegate, UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
    guard let sections = fetchedResultsController.sections else {
        return 0
    }
    
    return sections.count
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    guard let sectionInfo = fetchedResultsController.sections?[section] else {
        return 0
    }
    
    return sectionInfo.numberOfObjects
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutFeedViewController.feedCell, for: indexPath) as! FeedCell
    cell.workout = fetchedResultsController.object(at: indexPath)
    
    
    return cell
}

func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let sectionInfo = fetchedResultsController.sections?[section]
    return sectionInfo?.name
}
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    workoutSelected = fetchedResultsController.object(at: indexPath)
    performSegue(withIdentifier: WorkoutFeedViewController.kDetailSegueIdentifier, sender: self)
    
    }
}
