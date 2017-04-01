//
//  Artist+CoreDataClass.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/15/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import CoreData

protocol ItunesAPIDidFinishLoading:NSObjectProtocol {
    func dataIsReady()
}

public class Artist: NSManagedObject {
    typealias Year = String
    weak var delegate:ItunesAPIDidFinishLoading?
     override public var description: String {
        if let name = name {
            return name
        } else {
            return "No name."
        }
    }
    
    override  init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    //TODO - Change to create song
    class func findOrCreateArtist(matching artistName: String, in context: NSManagedObjectContext) throws -> Artist
    {
        let request:NSFetchRequest<Artist> = Artist.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %d",#keyPath(Artist.name), artistName)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "-- database inconsistency")
                return matches[0]
            }
            
        }catch {
            throw error
        }
        let artist = Artist(context: context)
        artist.name = artistName.replacingOccurrences(of: "+", with: " ").capitalized
        return artist
    }

    



}



