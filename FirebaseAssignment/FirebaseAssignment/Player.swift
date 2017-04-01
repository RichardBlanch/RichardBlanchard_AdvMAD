//
//  Recipe.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import Firebase


class Player:NSObject {
    var position:String?
    var throwingHand:String?
    var jerseyNumber:String?
    var name:String?
    var height:String?
    var battingHand:String?
    var age:String?
    weak var team:Team?
    
    
    init?(snapshot:FIRDataSnapshot) {
        if let snapshotValue = snapshot.value as? [String:String] {
            position = snapshotValue["bats"]
            throwingHand = snapshotValue["height"]
            jerseyNumber = snapshotValue["jersey_number"]
            name = snapshotValue["name"]
            height = snapshotValue["origin"]
            battingHand = snapshotValue["throws"]
            age = snapshotValue["weight"]
        }
    }
    override var hashValue : Int {
        return (name?.hashValue)!
    }
    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? Player else {
            return false
        }
        let lhs = self
        
        return lhs.name == rhs.name
    }
}

