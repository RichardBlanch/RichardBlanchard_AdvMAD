//
//  Track+CoreDataProperties.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/15/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track");
    }

    @NSManaged public var previewUrl: String?
    @NSManaged public var trackCensoredName: String?
    @NSManaged public var artworkUrl30: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var artist: Artist?

}
