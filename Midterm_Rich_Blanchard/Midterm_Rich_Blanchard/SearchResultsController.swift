//
//  SearchResultsController.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    var allWords = [String]()
    var filteredWords = [String]()
    private static let cellIdentifier = "CellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchResultsController.cellIdentifier)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredWords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = filteredWords[indexPath.row]
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wordHit = filteredWords[indexPath.row]
        print("User touched \(wordHit)")
    }
    
    
}
extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filteredWords.removeAll(keepingCapacity: true)
        if searchString?.isEmpty == false {
            let matches = allWords.filter({ (name) -> Bool in
                let range = name.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                return range != nil
            })
            filteredWords.append(contentsOf: matches)
        }
        tableView.reloadData()
        
    }
    
}

