//
//  Team.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/29/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class Team: NSObject {
    lazy private(set) var players:Set<Player>? = {
       let set = Set<Player>()
        return set
    }()
    var playersArrayValue: Array<Player>? {
        if let players = players {
            return Array(players) as [Player]
        }
        return nil
    }
    var teamName:String!
    
    init(withTeamName teamName:String) {
        self.teamName = teamName
    }
    func add(player:Player) {
        players!.insert(player)
    }

}
