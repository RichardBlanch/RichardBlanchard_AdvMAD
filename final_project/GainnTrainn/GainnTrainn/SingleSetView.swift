//
//  SingleSetView.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class SingleSetView: UIView {
    enum labelTag:Int {
        case kExerciseNameLabel = 100
        case kSetsLabel = 200
        case kRepsLabel = 300
        
        
    }
    private(set) var bottomHeight:CGFloat!
    var exerciseNumber:Int!
    var exercise:Exercise! {
        didSet {
            if let exerciseNameLabel = viewWithTag(labelTag.kExerciseNameLabel.rawValue) as? UILabel {
                exerciseNameLabel.text = exercise.name
            }
            if let setLabel = viewWithTag(labelTag.kSetsLabel.rawValue) as? UILabel {
                setLabel.text = exercise.sets
                
            }
            if let repsLabel = viewWithTag(labelTag.kRepsLabel.rawValue) as? UILabel {
                repsLabel.text = exercise.reps
                bottomHeight = CGFloat(exerciseNumber) * (repsLabel.frame.origin.y + repsLabel.frame.size.height + 1)
                print("Bottom height is \(bottomHeight)")
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
