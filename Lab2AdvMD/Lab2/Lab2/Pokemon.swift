//
//  Pokemon.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

class Pokemon: NSObject, NSCoding {
    var name:String!
    var url:URL!
    var abilities:[String]?
    let kName = "name"
    let kUrl = "url"
    
    init(name:String, url:String) {
        self.url = URL(string: url)
        self.name = name
        super.init()
    }
    init(name:String,fromUrl:URL) {
        self.url = fromUrl
        self.name = name
    }
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let url = aDecoder.decodeObject(forKey: "url") as! URL
        self.init(
            name: name,
            fromUrl: url
        )
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: kName)
        aCoder.encode(url, forKey:kUrl)
    }
}
//Code from http://stackoverflow.com/questions/26306326/swift-apply-uppercasestring-to-only-the-first-letter-of-a-string
extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    
}
