//
//  WorkoutHeaderView.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class WorkoutHeaderView: UIView {
    
    @IBOutlet private weak var workoutLabel:UILabel!
    @IBOutlet weak var workoutMainimageView:UIImageView!
    var workoutText:String! {
        didSet {
            workoutLabel.text = workoutText
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
