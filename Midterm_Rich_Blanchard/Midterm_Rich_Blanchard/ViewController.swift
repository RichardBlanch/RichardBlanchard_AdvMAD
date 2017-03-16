//
//  ViewController.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let resorts = SkiResorts.initializeResorts()
    var selectedResort:SkiResorts!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resorts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.textLabel?.text = resorts[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedResort = resorts[indexPath.row]
        performSegue(withIdentifier: "goToRuns", sender: self)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedResort = resorts[indexPath.row]
        performSegue(withIdentifier: "seeWeb", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRuns" {
            let runVC = segue.destination as! RunsViewController
            runVC.skiResortSelected = selectedResort
        } else if segue.identifier == "seeWeb" {
            let destVC = segue.destination as! WebViewController
            destVC.selectedResort = selectedResort
        }
    }
}

