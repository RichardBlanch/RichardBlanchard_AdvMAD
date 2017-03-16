//
//  RunsViewController.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class RunsViewController: UITableViewController {
    var skiResortSelected:SkiResorts!
    var searchController:UISearchController!

    @IBAction func addANewRun(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New Run", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            let newRunText = firstTextField.text
            let newRun = Runs(nameOfRun: newRunText!)
            self.skiResortSelected.runs?.append(newRun)
             self.changeRuns()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Run Name."
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func setUpSearchController() {
        
        let resultsController = SearchResultsController()
        let words = skiResortSelected.runs.map {$0.flatMap {$0.nameOfRun}}
        
        
        resultsController.allWords = words!
        searchController = UISearchController(searchResultsController: resultsController)
        
       
        searchController.searchBar.placeholder = "Enter a search term"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = resultsController
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skiResortSelected.runs!.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Runs", for: indexPath)
        cell.textLabel?.text = skiResortSelected.runs?[indexPath.row].nameOfRun
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            skiResortSelected.runs?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        self.changeRuns()
    }
    override func viewDidLoad() {
        setUpSearchController()
    }
    func changeRuns() {
        var newResorts = SkiResorts.initializeResorts()
        var i = 0
        for resort in SkiResorts.initializeResorts() {
            if resort.name == self.skiResortSelected.name {
                newResorts[i].runs = self.skiResortSelected.runs
            }
            i += 1
        }
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: newResorts)
        UserDefaults.standard.set(encodedData, forKey: "newResorts")
        UserDefaults.standard.synchronize()
    }
}
