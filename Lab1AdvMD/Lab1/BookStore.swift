//
//  BookStore.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/30/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreLocation

class BookStore: NSObject {
    var location:CLLocation!
    var name:String!
    var bookStoreImage:UIImage!
    init(location:CLLocation,name:String,bookStoreImage:UIImage) {
        self.location = location
        self.name = name
        self.bookStoreImage = bookStoreImage
    }
    class func createBookStores()->[BookStore] {
        
        let bookStores = [BookStore(location: CLLocation(latitude: 40.018021, longitude: -105.281162), name: "Boulder Book Store", bookStoreImage: UIImage(named: "Boulder-BoulderBookStore")!),BookStore(location: CLLocation(latitude: 40.0069, longitude: -105.2720), name: "CU Book Store", bookStoreImage: UIImage(named: "CU-BookStore")!),BookStore(location: CLLocation(latitude: 40.0196, longitude: -105.2726), name: "Red Letter Second Hand Books", bookStoreImage: UIImage(named: "RedLetterSecondHandBooks")!)]
        return bookStores
    }
    func getDistance(fromUsersLocation location:CLLocation)->CLLocationDistance? {
        let computedLocation = location.distance(from: self.location)
        return computedLocation
    }
}
extension CLLocationDistance {
    func convertToString()->String {
        let metersToMiles = self * 0.000621371
        let roundedStringValue = String(format:"%.2f", metersToMiles)
        return roundedStringValue
        
        
    }
}
