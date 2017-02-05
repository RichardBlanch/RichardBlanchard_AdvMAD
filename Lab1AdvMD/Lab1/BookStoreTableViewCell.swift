//
//  BookStoreTableViewCell.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/30/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreLocation

class BookStoreTableViewCell: UITableViewCell {
    @IBOutlet weak var bookStoreImageView: UIImageView!

    @IBOutlet weak var bookStoreDistanceLabel: UILabel!
    @IBOutlet weak var bookStoreNameLabel: UILabel!
    
    var bookStore:BookStore! {
        didSet {
            bookStoreImageView.image = bookStore.bookStoreImage
            bookStoreNameLabel.text = bookStore.name
        }
    }
    var location:CLLocation! {
        didSet {
            let distanceFrom = location.distance(from: bookStore.location)
            bookStoreDistanceLabel.text = "Distance: \(distanceFrom.convertToString() ?? "") miles"
            
        }
    }


}
