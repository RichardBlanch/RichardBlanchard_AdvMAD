import UIKit

class FavoritePokemon {
    static let sharedFavorites = FavoritePokemon() 
    private(set) var favorites:[Pokemon]
    
    
    init() {
        let defaults = UserDefaults.standard
        if let storedFavorites = defaults.object(forKey: "favorites") as? Data {
            favorites = NSKeyedUnarchiver.unarchiveObject(with: storedFavorites) as! [Pokemon]
        } else {
            favorites = [Pokemon]()
        }
    }
    func addFavorite(pokemon:Pokemon) {
        if !favorites.contains(pokemon) {
            favorites.append(pokemon)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
            UserDefaults.standard.set(encodedData, forKey: "favorites")
            UserDefaults.standard.synchronize()
        }
    }
    func removeFavorite(pokemon:Pokemon) {
        if let index = favorites.index(of: pokemon) {
            favorites.remove(at: index)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
            UserDefaults.standard.set(encodedData, forKey: "favorites")
            UserDefaults.standard.synchronize()
        }
    }
    
    
}
