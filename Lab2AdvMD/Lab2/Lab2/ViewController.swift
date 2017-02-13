//
//  ViewController.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

protocol HaveFetchedPokemonFromAPI: NSObjectProtocol {
    func updateTableView()
}

class ViewController: UITableViewController {
    let pokemonHelper = PokemonAPIHelper()
    var pokemon:[Pokemon]?
    private static let cellIdentifier = "cellIdentifier"
      var searchController:UISearchController!
    private var originalEndPoint = URL(string: "http://pokeapi.co/api/v2/pokemon/")!
    var selectedPokemon:Pokemon!
    let goToDetailPokemon = "goToDetailPokemon"
    lazy var userDefaults = UserDefaults.standard
    var allPokemon:[Pokemon]!
    
    
   
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator() {
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator = UIActivityIndicatorView(frame: frame)
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = self.view.center
         self.indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
    }

    @IBAction func didHitSegment(_ sender: Any) {
        let segment = sender as! UISegmentedControl
        if segment.selectedSegmentIndex == 0 {
            pokemon = allPokemon
        } else {
            pokemon = FavoritePokemon.sharedFavorites.favorites
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pokemon"
        navigationItem.leftBarButtonItem = self.editButtonItem
       
        
        if let data = userDefaults.object(forKey: "pokemon") {
            self.pokemon = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [Pokemon]?
            allPokemon = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [Pokemon]?
            setUpSearchController()
        } else {
            pokemonHelper.delegate = self
            pokemonHelper.fetchPokemon(endPoint: originalEndPoint)
            self.activityIndicator()
           
           
        }
        
        
        
        
      
    }
    func setUpSearchController() {
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        let words:[String] = (pokemon?.flatMap({ (pokemon) -> String? in
            return pokemon.name
        }))!
        resultsController.allWords = words
        resultsController.pokemon = self.pokemon
        searchController = UISearchController(searchResultsController: resultsController)
        resultsController.delegate = self
        
        
        searchController.searchBar.placeholder = "Enter a search term"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = resultsController
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToDetailPokemon {
            let detailViewController = segue.destination as! PokemonDetailViewController
            detailViewController.pokemon = selectedPokemon
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = pokemon?.count else {
            return 0
        }
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = pokemon?[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = pokemon?[indexPath.row]
        performSegue(withIdentifier: goToDetailPokemon, sender: self)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.pokemon?.count == FavoritePokemon.sharedFavorites.favorites.count {
            return true
        } else {
            return false
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoritePokemon.sharedFavorites.removeFavorite(pokemon: (self.pokemon?[indexPath.row])!)
            pokemon = FavoritePokemon.sharedFavorites.favorites
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
   
}
extension ViewController: HaveFetchedPokemonFromAPI {
    func updateTableView() {
   OperationQueue.main.addOperation {
    self.indicator.stopAnimating()
    self.pokemon = self.pokemonHelper.pokemonArray.sorted {$0.name < $1.name}
    self.allPokemon = self.pokemonHelper.pokemonArray.sorted {$0.name < $1.name}
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.pokemon)
    self.userDefaults.set(encodedData, forKey: "pokemon")
    self.userDefaults.synchronize()
    self.tableView.reloadData()
    self.setUpSearchController()
        }
    }
}
extension ViewController: didSelectSearchResult {
    func userDidHitPokemonFromSearchResult(withPokemon pokemon:Pokemon) {
        self.selectedPokemon = pokemon
        performSegue(withIdentifier: goToDetailPokemon, sender: self)
        
    }
}


