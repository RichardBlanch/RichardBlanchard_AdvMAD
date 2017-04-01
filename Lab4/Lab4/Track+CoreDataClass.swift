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
    class func findOrCreateSong(matching trackCensoredName: String, withJSON JSON:[String:Any], andArtist artist:Artist, in context: NSManagedObjectContext) throws -> Track
    {
        let request:NSFetchRequest<Track> = Track.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %d",#keyPath(Track.trackCensoredName), trackCensoredName)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "-- database inconsistency")
                return matches[0]
            }
            
        }catch {
            throw error
        }
        let track = Track(context: context)
        track.previewUrl = JSON["previewUrl"] as? String
        track.trackCensoredName = JSON["trackCensoredName"] as? String
        track.artworkUrl30 = JSON["artworkUrl100"] as? String
        track.primaryGenreName = JSON["primaryGenreName"] as? String
        track.artist = artist
        return track
    }
   
    
}
