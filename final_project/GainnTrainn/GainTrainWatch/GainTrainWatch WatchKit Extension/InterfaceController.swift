//
//  InterfaceController.swift
//  GainTrainWatch WatchKit Extension
//
//  Created by Rich Blanchard on 2/19/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        HealthKitHelper.sharedHelper.getPermission()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
