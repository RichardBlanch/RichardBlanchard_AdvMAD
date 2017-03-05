//
//  ViewController.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var typeOfAuthentication:String!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DogstagramNetworker.sharedNetworker.delegate = self
        DogstagramNetworker.sharedNetworker.callApiToGetImage()
    }
}
extension ViewController: GetImageFromGoogleAPI {
    func getImagesFromGoogleAPI(withStreetView: [StreetView]) {
        for img in withStreetView {
            imageView.image = img.image
        }
    }
}


