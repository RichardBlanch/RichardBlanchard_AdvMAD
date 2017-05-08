//
//  JournalTableViewCell.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/22/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var weightinputTextField: UITextField!
    var section:Int!
    var row:Int!
    
    var weightInput:String? {
        return weightinputTextField.text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
    
}
