//
//  ImageTransformable.swift
//  WiseCork
//
//  Created by Rich Blanchard on 2/1/17.
//  Copyright © 2017 Rich. All rights reserved.
//
import Foundation
import UIKit

@objc(ImageTransformer)
class ImageTransformer: ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        return UIImage(data: data)
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        
        return UIImageJPEGRepresentation(image, 1.0)
    }
}
extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

