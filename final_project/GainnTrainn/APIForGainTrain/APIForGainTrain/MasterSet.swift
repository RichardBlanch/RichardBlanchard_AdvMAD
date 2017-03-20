//
//  MasterSet.swift
//  GainTrainAPI
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

public class MasterSet: NSObject {
    public var workout: Workout?
    public var exercises: [Exercise]?
    public override init() {
        super.init()
    }
    
}
