//
//  Exercise+CoreDataProperties.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


public class Exercise:NSObject {
    
    
    
    public var reps: String?
    public var sets: String?
    public var name: String?
    public var masterSet: MasterSet?
    
    private let kReps = "reps"
    private let kSets = "sets"
    private let kName = "name"
    
    public init(json:[String:AnyObject]) {
        self.reps = json[kReps] as! String
        self.name = json[kName] as? String ?? "THIS VALUE IS NIL"
        self.sets = json[kSets] as! String
        super.init()
        
    }
    
}
