//
//  DogstagramNetworkHelper.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import UIKit
protocol GetImageFromGoogleAPI: NSObjectProtocol {
    func getImagesFromGoogleAPI(withStreetView:[StreetView])
}

class Networker: NSObject {
     static let sharedNetworker = Networker()
     lazy var endPoint:URLRequest! = {
       let stringEndpoint = NSString(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", Constants.INSTAGRAM_AUTHURL, Constants.INSTAGRAM_CLIENT_ID, Constants.INSTAGRAM_REDIRECT_URI, Constants.INSTAGRAM_SCOPE) as! String
        let urlEndpoint = URL(string: stringEndpoint)
        return URLRequest(url: urlEndpoint!)
    }()
    private let kData = "data"
    weak var delegate:GetImageFromGoogleAPI?
    var images = [UIImage]() {
        didSet {
            if images.count == 7 {
                addImagesToStreetViews(withStreetViews: streetViews)
            }
        }
    }
    var streetViews =  StreetView.createCities()!
    
   
    
    
    
    
    
   
    
    var urlSession:URLSession!
    override init() {
        super.init()
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func callApiToGetImage() {
        
        
        //https://www.raywenderlich.com/148515/grand-central-dispatch-tutorial-swift-3-part-2 code inspired from.
        let downloadGroup = DispatchGroup()
        DispatchQueue.global(qos: .userInitiated)
        DispatchQueue.concurrentPerform(iterations: (streetViews.count)) {
            i in
            let index = Int(i)
            let city = streetViews[index]
            let string = "https://maps.googleapis.com/maps/api/streetview?size=600x300&location=\(city.location.coordinate.latitude),\(city.location.coordinate.longitude)&heading=151.78&pitch=-0.76&key=AIzaSyBtqW5pVun2Isj-541_4_LM-YgrBFmtN7M"
            let url = URL(string: string)
            downloadGroup.enter()
            urlSession.downloadTask(with: url!, completionHandler: { (urlRes, response, error) in
                do {
                    if let urlRes = urlRes {
                        let data = try Data(contentsOf: urlRes)
                        let image = UIImage(data: data)
                        self.images.append(image!)
                        self.streetViews[index].image = image
                        downloadGroup.leave()
                        
                    }
                }catch {
                    print("error")
                }
            }).resume()
        }
        downloadGroup.notify(queue: DispatchQueue.main) {
            print("done")
        }
    }
    
        

 
            
            
            
        
        
    
    func addImagesToStreetViews(withStreetViews streetViews:[StreetView]) {
        OperationQueue.main.addOperation { 
            self.delegate?.getImagesFromGoogleAPI(withStreetView: streetViews)
        }
        
        
    }

}

