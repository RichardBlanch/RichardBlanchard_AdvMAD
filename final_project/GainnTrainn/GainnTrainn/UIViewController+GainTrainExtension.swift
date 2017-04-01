//
//  UIViewController+GainTrainExtension.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/22/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

extension UIViewController {
    var contents: UIViewController {
        if let navCont = self as? UINavigationController {
            return navCont.visibleViewController ?? self // I am a navcontroller
        } else {
            return self
        }
    }
}
