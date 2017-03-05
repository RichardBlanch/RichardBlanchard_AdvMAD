//
//  StreetView.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class StreetView: NSObject {
    var location:CLLocation!
    var cityName:String!
    var haveLived:Bool!
    var image:UIImage?
    var revampedImage:UIImage?
    
    private init(location:CLLocation, cityName:String,haveLived:Bool) {
        self.location = location
        self.cityName = cityName
        self.haveLived = haveLived
        super.init()
    }
    class func createCities()->[StreetView]? {
        
        var city = [StreetView(location: CLLocation(latitude: 38.291859, longitude: -122.458036), cityName: "Sonoma",haveLived: true),
                    StreetView(location:CLLocation(latitude: 40.0076, longitude: -105.2659) , cityName: "Boulder", haveLived:true),
                    StreetView(location:CLLocation(latitude: 40.7831, longitude: -73.9712) , cityName: "New York", haveLived:true),
                    StreetView(location:CLLocation(latitude: 50.1163, longitude: -122.9574) , cityName: "Vancouver",haveLived:true),
                    StreetView(location: CLLocation(latitude: 47.181402, longitude: 0.0517099), cityName: "France", haveLived: false),
                    StreetView(location: CLLocation(latitude: 27.1738903, longitude: 78.0419927), cityName: "Taj Mahal", haveLived: false),
                    StreetView(location: CLLocation(latitude: 29.9803885, longitude: 31.1329825), cityName: "Pyramids of Giza", haveLived: false)
            
                    
                    
        ]
        return city
    }
}
