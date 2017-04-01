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
    var weightInput:String? = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
    
}
