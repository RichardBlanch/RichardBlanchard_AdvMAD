//
//  FeedCell.swift
//  feed2
//
//  Created by Nevin Jethmalani on 4/16/16.
//  Copyright © 2016 Notify Nearby. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var feedViewShadow: UIView!
    @IBOutlet weak var mainViewInCell: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var retailerNameLabel: UILabel!
    @IBOutlet weak var offerTitleLabel: UILabel!
    var workoutImage:UIImage! {
        didSet {
            mainImage.image = workoutImage
        }
    }
    var universalUIElements = UniversalUIElements()
    var workout:Workout! {
        didSet {
            retailerNameLabel.text = workout.name
            offerTitleLabel.text = workout.creator
            descriptionText.text = workout.bodyType
        }
    }

    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //this is the shadow for each of the two feed elements
        //universalUIElements.shadowForFeed(feedViewShadow)
        
        
        //Removes the padding and spacing that a Text View has
        universalUIElements.removeTextViewInset(descriptionText)
        
        //Adds Border around logo image in feed
        universalUIElements.logoBorder(logoView)
    }
    
}
