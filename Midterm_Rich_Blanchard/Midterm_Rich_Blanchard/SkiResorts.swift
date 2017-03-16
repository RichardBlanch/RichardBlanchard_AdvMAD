//
//  SkiResorts.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

class SkiResorts: NSObject,NSCoding {
    var runs: [Runs]?
    var name: String!
    var url: String!
    init(runs:[Runs],name:String,url:String) {
        self.runs = runs
        self.name = name
        self.url = url
    }
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let url = aDecoder.decodeObject(forKey: "url") as! String
        let runs = aDecoder.decodeObject(forKey: "runs") as! [Runs]
        self.init(runs:runs, name:name, url:url)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(url, forKey: "url")
        aCoder.encode(runs, forKey: "runs")
    }
    class func initializeResorts()->[SkiResorts] {
        
        if let data = UserDefaults.standard.object(forKey: "newResorts") {
            let resorts = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [SkiResorts]
            return resorts
        }
            let trestle = Runs(nameOfRun: "Trestle")
            let outhouse = Runs(nameOfRun: "Outhouse")
            return [SkiResorts(runs: [trestle,outhouse], name: "Winter Park", url: "https://www.snow.com/"), SkiResorts(runs: [trestle,outhouse], name: "Aspen", url: "https://www.aspensnowmass.com/"), SkiResorts(runs: [trestle,outhouse], name: "Eldora", url:"https://www.eldora.com/"), SkiResorts(runs: [trestle,outhouse], name: "Steamboat",url:"https://www.steamboat.com/")]
        
     
        
        
    }
    
}
