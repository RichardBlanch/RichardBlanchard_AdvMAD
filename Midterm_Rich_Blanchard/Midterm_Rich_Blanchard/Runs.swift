//
//  Runs.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class Runs: NSObject {
    var nameOfRun:String!
    
    init(nameOfRun:String) {
        self.nameOfRun = nameOfRun
    }
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "nameOfRun") as! String
        self.init(nameOfRun: name)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nameOfRun, forKey: "nameOfRun")
    }

}
