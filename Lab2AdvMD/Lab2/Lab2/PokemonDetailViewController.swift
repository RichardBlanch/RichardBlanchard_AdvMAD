//
//  PokemonDetailViewController.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
public enum labelTag: Int {
    case kAbilityOne = 100
    case kAbilityTwo = 200
    case kAbilityThree = 300
}
class PokemonDetailViewController: UIViewController {
    
   
    
    var pokemon:Pokemon!
    let pokemonHelper = PokemonAPIHelper()
    
    @IBOutlet weak var abilitiesView: AbilitiesView!
    
   
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pokemonName:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var contentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageView:UIImageView!
    var activityIndicator:UIActivityIndicatorView!
   
    @IBOutlet weak var bottomSeperatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentViewWidth.constant = view.frame.size.width
        pokemonName.text = pokemon.name
        
        pokemonHelper.fetchSoloPokemon(fromURL: pokemon.url) { (abilities) in
            self.pokemon.abilities = abilities
            OperationQueue.main.addOperation({
                if let labelOne = self.abilitiesView.viewWithTag(labelTag.kAbilityOne.rawValue) as? UILabel {
                    if self.pokemon.abilities?.indices.contains(0) == true {
                        labelOne.text = self.pokemon.abilities?[0]
                        
                    } else {
                        labelOne.isHidden = true
                    }
                }
                if let labelTwo = self.abilitiesView.viewWithTag(labelTag.kAbilityTwo.rawValue) as? UILabel {
                    if self.pokemon.abilities?.indices.contains(1) == true {
                        labelTwo.text = self.pokemon.abilities?[1]
                    } else {
                        labelTwo.isHidden = true
                    }
                    
                }
                if let labelThree = self.abilitiesView.viewWithTag(labelTag.kAbilityThree.rawValue) as? UILabel {
                    if self.pokemon.abilities?.indices.contains(2) == true {
                        labelThree.text = self.pokemon.abilities?[2]
                    } else {
                        labelThree.isHidden = true
                    }
                    
                }
                self.activityIndicator.stopAnimating()
            })
        }
        
        
        
        abilitiesView = Bundle.main.loadNibNamed("AbilitiesNib", owner: self, options: nil)?[0] as! AbilitiesView
        let startingHeight = bottomSeperatorView.frame.origin.y + 2
        
        abilitiesView.frame = CGRect(x: 0, y: startingHeight, width: 375, height: 200)
        contentView.addSubview(abilitiesView)
        addSpinner()
        
    }
    func addSpinner() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        abilitiesView.addSubview(activityIndicator)
         activityIndicator.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 25, y: 100, width: 50, height: 50)
        activityIndicator.startAnimating()
    }
  
    @IBAction func addPokemonToFavorites(_ sender: Any) {
        FavoritePokemon.sharedFavorites.addFavorite(pokemon: pokemon)
    }



}
