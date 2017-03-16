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
    init(name:String) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Artist", in: ArtistService.sharedCellarService.managedObjectContext)
        super.init(entity:entityDescription! , insertInto: ArtistService.sharedCellarService.managedObjectContext)
        self.name = name.replacingOccurrences(of: "+", with: " ").capitalized
        
    }
    



}



