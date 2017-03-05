//
//  HeaderView.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    var labelText:String! {
        didSet {
            if let label = viewWithTag(100) as? UILabel {
                label.text = labelText
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.black
        
    }
        
}
