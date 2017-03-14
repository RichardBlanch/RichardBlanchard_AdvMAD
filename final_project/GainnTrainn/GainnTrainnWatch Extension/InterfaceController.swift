//
//  InterfaceController.swift
//  GainnTrainnWatch Extension
//
//  Created by Rich Blanchard on 2/19/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
   
    @IBOutlet var tableView: WKInterfaceTable!
     let session = WCSession.default()
     lazy var workouts = [String]()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        processApplicationContext()
        session.delegate = self
        session.activate()
        setUpTable()
       
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func processApplicationContext() {
        if let iPhoneContext = session.receivedApplicationContext as? [String:Any] {
            if let string = iPhoneContext["workouts"] as? [[String:AnyObject]] {
            for strang in string {
                workouts.append(strang["name"] as! String)
                }
                setUpTable()
            } else {
                print("No value")
            }
        }
    }
    func setUpTable() {
        tableView.setNumberOfRows(workouts.count, withRowType: "WorkoutRow")
        for i in 0..<workouts.count {
            let row = tableView.rowController(at: i) as! WorkoutRow
            row.nameLabel.setText(workouts[i])
        }
        
    }

}
extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("MESSAGE IS \(message)")
    }
     func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activation state is \(activationState)")
       
       
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
       OperationQueue.main.addOperation { 
            self.processApplicationContext()
        }
    }
    
}

