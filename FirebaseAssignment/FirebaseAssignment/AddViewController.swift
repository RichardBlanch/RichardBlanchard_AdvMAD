//
//  AddViewController.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    private let cancelSegueIdentifier = "cancelSegueIdentifier"
     private let donesegueIdentifier = "doneSegueIdentifier"
    
    @IBOutlet weak  var nameTextfield: UITextField! {
        didSet {
            nameToAdd = nameTextfield.text
        }
    }
    @IBOutlet weak  var urlTextfield: UITextField! {
        didSet {
            urlToAdd = urlTextfield.text
        }
    }
    
    var nameToAdd:String?
    var urlToAdd:String?
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == cancelSegueIdentifier {
               
                
            } else if identifier == donesegueIdentifier {
               nameToAdd = nameTextfield.text
               urlToAdd = urlTextfield.text
            }
            
        }
    }
    
  

}
