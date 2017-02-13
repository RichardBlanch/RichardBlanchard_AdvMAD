//
//  PokemonHelper.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

class PokemonAPIHelper: NSObject {
    lazy private var dataSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    private var results = "results"
    private var name = "name"
    private var url = "url"
    private(set) var pokemonArray = [Pokemon]()
    weak var delegate:HaveFetchedPokemonFromAPI?
   
    func fetchPokemon(endPoint:URL) {
       dataSession.dataTask(with: endPoint) { (data, response, error) in
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String:AnyObject]
            if let next = jsonData?["next"] as? String {
                let nextURL = URL(string: next)
                self.fetchPokemon(endPoint: nextURL!)
                for pokemonDictionary in (jsonData?["results"] as? [[String:AnyObject]])! {
                    let name = pokemonDictionary[self.name] as! String
                    print("name is \(name)")
                     let pokemon = Pokemon(name: name.capitalizingFirstLetter(), url: pokemonDictionary[self.url] as! String)
                    self.pokemonArray.append(pokemon)
                }
            } else {
                self.delegate?.updateTableView()
            }
            
        } catch let error as NSError {
            print("Error is \(error)")
        }
        }.resume()
    }
    func fetchSoloPokemon(fromURL url:URL,completionHandler:@escaping ([String])->Void) {
        dataSession.dataTask(with: url) { (data, response, error) in
            do {
                let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as! [String:AnyObject]
                let abilities = data["abilities"] as! [[String:AnyObject]]
                var abilitiesArray = [String]()
                for ability in abilities {
                    
                    abilitiesArray.append(ability["ability"]?["name"] as? String ?? "nil")
                }
                completionHandler(abilitiesArray)
                
            } catch {
                
            }
        }.resume()
    }
}
