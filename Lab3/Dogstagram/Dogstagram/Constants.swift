//
//  Constants.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static var INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static var INSTAGRAM_CLIENT_ID = "e972b7e2818b4cc9b716a75458c846bf"
    static var INSTAGRAM_SCOPE = "likes+comments+relationships+public_content"
    static var INSTAGRAM_REDIRECT_URI = "http://www.shoplooq.com"
    
}
extension UIImage {
    func makeImageBigger(withFrame frame:CGRect)->UIImage {
    // code to create resized image from https://www.snip2code.com/Snippet/89236/Resize-Image-in-iOS-Swift
    var newImage = UIImage()
    let newSize:CGSize = CGSize(width: (self.size.width) * 10, height: (self.size.height) * 10)
   
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    self.draw(in: frame)
    newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
    }
    
}
