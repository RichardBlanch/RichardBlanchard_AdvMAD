//
//  DetailViewController.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var streetView:StreetView!
    
    @IBOutlet weak var revampedImageView:UIImageView!
     @IBOutlet weak var distanceLabel:UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        revampedImageView.image = streetView.revampedImage
        navigationItem.title = streetView.cityName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(DetailViewController.shareImage))
        guard let location = LocationService.sharedInstance.currentLocation else {
            return
        }
        let distance = location.distance(from: streetView.location)
        var miles = distance * 0.000621371
       
        let stringValue = NSString(format: "%.2f miles", miles)
        if let stringValue = stringValue as? String {
            distanceLabel.text = stringValue
        }
    }

   
    func shareImage() {
       let activityView = UIActivityViewController(activityItems: [streetView.revampedImage], applicationActivities: nil)
       present(activityView, animated: true, completion: nil)
    }
    @IBAction func giveDirections(_ sender: Any) {
        guard let location = LocationService.sharedInstance.currentLocation else {
            return
        }
        guard let directionsURL = URL(string:"http://maps.apple.com/?saddr=\(location.coordinate.latitude ?? 0.0),\(location.coordinate.longitude)&daddr=\(streetView.location.coordinate.latitude),\(streetView.location.coordinate.longitude ?? 0.0)") else {
            return
        }
        
        UIApplication.shared.open(directionsURL, options: [:], completionHandler: nil)
    }


}
