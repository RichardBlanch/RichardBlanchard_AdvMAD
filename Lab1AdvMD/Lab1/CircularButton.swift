//
//  MarysButton.swift
//  Mary's Pizza Shack
//
//  Created by Rich Blanchard on 8/17/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

import UIKit

class CircularButton: UIButton {
    
    var imageColor:UIImage? {
        didSet
        {
            setUp()
        }
    }
    
    
    var detailImage:UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    convenience init(frame:CGRect, detailImage:UIImage, imageColor:UIImage)
    {
        self.init(frame: frame)
        self.detailImage = detailImage
        self.imageColor = imageColor
    }
    
    
    
    
    
    
    func setUp()
    {
        if let color = imageColor{
            setBackgroundImage(color, for: .normal)
        }
        if let detail = detailImage {
            setImage(detailImage, for: .normal)
        }
        
        tintColor = UIColor.white
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
    
    
}
