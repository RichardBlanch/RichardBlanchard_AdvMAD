//
//  FourSquareHelper.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreLocation

class FourSquareHelper:NSObject {
    lazy private var dataSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    func getData() {
       var currentLocation = LocationService.sharedInstance.getLocation() ?? CLLocation(latitude: 90, longitude: 90)
        
        guard let endpoint = URL(string:"https://api.foursquare.com/v2/venues/search?ll=\(currentLocation.coordinate.latitude ?? 90),\(currentLocation.coordinate.longitude ?? 90)&client_id=A2VHJDBOOVR5YGHYUABY5QT4MPTU2DKLHOMYFMHZAJB3X0LB&client_secret=RJN2CQ4OXNR5455B44TVCQXO3H5F3ISDIVFTDYZPUIY04FLK&v=20160212") else {
            return
        }
        print("The endpoint is \(endpoint.absoluteString)")
        dataSession.dataTask(with: endpoint) { (data, resposne, error) in
            guard error == nil else {
                return
            }
            guard data != nil else {
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String:AnyObject]
                print("JsonData is \(jsonData)")
            } catch let error as Error {
                print("error serializng json is \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
}
