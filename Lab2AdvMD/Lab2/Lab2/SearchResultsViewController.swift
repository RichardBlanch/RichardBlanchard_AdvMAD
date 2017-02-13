//
//  SearchResultsViewController.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
protocol didSelectSearchResult:NSObjectProtocol {
    func userDidHitPokemonFromSearchResult(withPokemon pokemon:Pokemon)
}

class SearchResultsController: UITableViewController {
    var allWords = [String]()
    var filteredWords = [String]()
    var matchedPokemon = [Pokemon]()
    var pokemon:[Pokemon]!
    private static let cellIdentifier = "CellIdentifier"
    weak var delegate:didSelectSearchResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchResultsController.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedPokemon.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = matchedPokemon[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: false, completion: nil)
        delegate?.userDidHitPokemonFromSearchResult(withPokemon: matchedPokemon[indexPath.row])
    }


}
extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        matchedPokemon.removeAll(keepingCapacity: true)
        if searchString?.isEmpty == false {
            
            let matches = pokemon.filter({ (pokemon) -> Bool in
                let range = pokemon.name.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                return range != nil
            })
            matchedPokemon += matches
        }
        tableView.reloadData()
        
    }
    
}
