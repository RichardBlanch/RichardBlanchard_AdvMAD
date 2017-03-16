//
//  Track+CoreDataClass.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/15/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


public class Track: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init(withJSON json:[String:Any], andArtist artist:Artist) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Track", in: ArtistService.sharedCellarService.managedObjectContext)
        super.init(entity: entityDescription!, insertInto: ArtistService.sharedCellarService.managedObjectContext)
        self.previewUrl = json["previewUrl"] as? String
        self.trackCensoredName = json["trackCensoredName"] as? String
        self.artworkUrl30 = json["artworkUrl100"] as? String
        self.primaryGenreName = json["primaryGenreName"] as? String
        self.artist = artist
        
    }
   
    
}
