//
//  WorkoutFilterByCollectionViewCell.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/21/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class WorkoutFilterByCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var filterByImageView: UIImageView!
    @IBOutlet private weak var workoutType: UILabel!
    
    var imageWithBodyType:(workoutImage:UIImage,workoutBodyType:String)! {
        didSet {
            setUpUI()
        }
    }
    private func setUpUI() {
        filterByImageView.image = imageWithBodyType.workoutImage
        workoutType.text = imageWithBodyType.workoutBodyType
    }
    
}
