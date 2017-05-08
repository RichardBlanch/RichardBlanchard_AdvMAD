//
//  RemoveAll.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit


    class RemoveAll: UIButton {
        var imageColor:UIImage? {
            didSet
            {
                setUp()
            }
        }
        var detailImage:UIImage?
        
        override func awakeFromNib() {
            animateOnPress(true)
            setUp()
        }
        
        let pressDuration = 0.1
        
        func animateOnPress(_ animate: Bool)   {
            if animate  {
                self.addTarget(self, action: #selector(self.pressAnimation), for: .touchDown)
                self.addTarget(self, action: #selector(self.unpressAnimation), for: .touchUpInside)
            }
        }
        
        @objc private func pressAnimation()   {
            UIView.animate(withDuration: self.pressDuration, animations: {
                self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            })
        }
        
        @objc private func unpressAnimation()   {
            UIView.animate(withDuration: self.pressDuration, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
        
        func setDefaultImage(withName imageName: String)  {
            if let image = UIImage(named: imageName) {
                self.setImage(image, for: .normal)
            }
        }
        
        func setSelectedImage(withName imageName: String, withColor color: UIColor) {
            if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)  {
                self.setImage(image, for: .selected)
                self.tintColor = color
            }
            
            if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)  {
                self.setImage(image, for: .highlighted)
                self.tintColor = color
            }
        }
        func setUp()
        {
            if let color = imageColor {
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
