//
//  ViewController.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import FirebaseDatabase
class RecipesTableViewController: UITableViewController {
    var reference:FIRDatabaseReference! {
        didSet {
            readDataFromFirebase()
        }
    }
    
    var teams = [Team]()
    var spinner:UIActivityIndicatorView!
    
    
    fileprivate static let cellIdentifier =  "RecipeCell"
    private let playerDetailSeguw = "playerDetail"
   
    
    //DATA COMES FROM FIREBASE WHICH WAS OBTAINED FROM get_mlb_players.py
    override func viewDidLoad() {
        super.viewDidLoad()
        reference = FIRDatabase.database().reference()
        createSpinner()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == playerDetailSeguw {
            let destVC = segue.destination as! PlayerDetailViewController
            let cell = sender as! UITableViewCell
            if let indexPatth = tableView.indexPath(for: cell) {
                let player = self.teams[indexPatth.section].playersArrayValue?[indexPatth.row]
                destVC.player = player
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = teams[section].players?.count else {
            return 0
        }
        print("the count is \(count)")
        return count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("count is \(teams.count)")
        return teams.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teams[section].teamName
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipesTableViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = teams[indexPath.section].playersArrayValue![indexPath.row].name
        return cell
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.teams.flatMap {$0.teamName}
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    func getTeams(completionHandler:@escaping ([String])->Void) {
        var teamNames = [String]()
        reference.child("teams").observe(.value, with: { (snapShot) in
            for team in snapShot.children.allObjects as! [FIRDataSnapshot] {
                teamNames.append(team.key)
            }
            completionHandler(teamNames)
        })
    }
    func readDataFromFirebase() {
        getTeams { [weak self](teamNames) in
                var i = 0
                for team in teamNames {
                    let teamObj = Team(withTeamName: team)
                    self?.reference.child("teams").child(team).child("players").observe(.value, with: { (playerSnapshot) in
                        let players = playerSnapshot.children.allObjects as! [FIRDataSnapshot]
                        for playa in players {
                            if let player = Player(snapshot: playa) {
                                player.team = teamObj
                                teamObj.add(player: player)
                            }
                        }
                        
                         self?.teams.append(teamObj)
                         i+=1
                        if i == teamNames.count {
                            DispatchQueue.main.async {
                                self?.spinner.stopAnimating()
                                self?.tableView.reloadData()
                            }
                        }
                    })
                   
            }
        }
    }
    func createSpinner() {
        spinner = UIActivityIndicatorView(frame: CGRect(x: tableView.bounds.midX - 15, y: tableView.bounds.midY - 15, width: 30, height: 30))
        spinner?.hidesWhenStopped = true
        spinner?.startAnimating()
        spinner?.color = .black
        tableView.addSubview(spinner)
    }
}

