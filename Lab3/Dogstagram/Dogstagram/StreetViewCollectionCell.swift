//
//  StreetViewCollectionCell.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class StreetViewCollectionCell: UICollectionViewCell {
    var streetView:StreetView! {
        didSet {
            
            streetViewImageView.image = streetView.image
        }
    }
    
    
    @IBOutlet weak var streetViewImageView:UIImageView!
    
}
