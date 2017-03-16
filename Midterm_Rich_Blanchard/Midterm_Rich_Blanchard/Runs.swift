//
//  Runs.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class Runs: NSObject,NSCoding {
    var nameOfRun:String!
    let kName = "nameOfRun"
    
    init(nameOfRun:String) {
        self.nameOfRun = nameOfRun
    }
    init(name:String) {
        
        self.nameOfRun = name
    }
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "nameOfRun") as! String
        self.init(
            name: name
        )
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nameOfRun, forKey: kName)
       
    }

}
