//
//  Recipe.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import Firebase


struct Recipe {
    var name:String
    var url:String
    
    init(name:String, url:String) {
        self.name = name
        self.url = url
    }
    init(snapshot:FIRDataSnapshot) {
        let snapshotValye = snapshot.value as! [String:String]
        name = snapshotValye["name"]!
        url = snapshotValye["url"]!
    }
}
