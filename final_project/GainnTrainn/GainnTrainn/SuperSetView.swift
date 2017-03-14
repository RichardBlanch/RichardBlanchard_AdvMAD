//
//  SuperSetView.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class SuperSetView: UIView {
    enum labelTags:Int {
        case exerciseNameOne = 100
        case setsNameOne = 200
        case repsNameOne = 300
        
        case exerciseNameTwo = 1000
        case setsNameTwo = 2000
        case repsNameTwo = 3000
    }
    var exercise:[Exercise]! {
        didSet {
           
            if let labelOne = viewWithTag(labelTags.exerciseNameOne.rawValue) as? UILabel {
                labelOne.text = exercise[0].name
            }
            if let labelOneTwo = viewWithTag(labelTags.setsNameOne.rawValue) as? UILabel {
                labelOneTwo.text = exercise[0].sets
            }
            if let labelOneThree = viewWithTag(labelTags.repsNameOne.rawValue) as? UILabel {
                labelOneThree.text = exercise[0].reps
            }
            
        }
    }

    func viewFromNib()->UIView {
        let nibName = "SingleSet"
        let nibViews = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UIView
        return nibViews
    }
    func addSubviewFromNib() {
        let view = self.viewFromNib()
        view.frame = self.bounds
        addSubview(view)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
