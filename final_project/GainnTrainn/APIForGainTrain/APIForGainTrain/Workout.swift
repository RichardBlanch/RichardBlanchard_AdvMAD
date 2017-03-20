//
//  Workout.swift
//  GainTrainAPI
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
public class Workout:NSObject {
    public var workoutId: Int32
    public var creator: String?
    public var name: String?
    public var bodyType: String?
    public var imageWidth: Int16
    public var imageHeight: Int16
    public var imageURL: String?
    public var mainImage: UIImage?
    public var masterSets: [MasterSet]?
    public var forDates: NSSet?
    
    var aspectRatio:CGFloat {
        return CGFloat(CGFloat(imageHeight) / CGFloat(imageWidth))
    }
    
    private let kID = "id"
    private let kCreator = "creator"
    private let kName = "name"
    private let kBodyType = "body_type"
    private let kImageWidth = "img_width"
    private let kImageHeight = "img_height"
    private let kImageURL = "img_url"
    
    
    
    init(json:[String:Any]) {
        self.workoutId = json[kID] as! Int32
        self.creator = json[kCreator] as? String ?? "NIL"
        self.name = json[kName] as! String
        self.bodyType = json[kBodyType] as? String
        self.imageWidth = json[kImageWidth] as! Int16
        self.imageHeight = json[kImageHeight] as! Int16
        self.imageURL = json[kImageURL] as? String ?? "https://www.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiit_treadmill_workouts_for_fat_loss.jpg"
        let url = URL(string: self.imageURL!)!
        super.init()
    }
}


