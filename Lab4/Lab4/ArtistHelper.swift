//
//  ArtistHelper.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation



class ArtistHelper:NSObject {
     weak var delegate:ItunesAPIDidFinishLoading?
    private class func getArtists()->[String:[String]] {
    let artistsPath = Bundle.main.path(forResource: "Artists", ofType: "plist")
    let artistsDictionary = NSArray(contentsOfFile: artistsPath!)?[0] as! [String: [String]]
    return artistsDictionary
    }
    
    
    func normalizeData() {
    var artists = ArtistHelper.getArtists()
    
    for key in Array(artists.keys) {
        var artistsStrings:[String] = artists[key]!
        artistsStrings = artistsStrings.flatMap {$0.replacingOccurrences(of: " ", with: "+").lowercased()}
        artists[key] = []
        artists[key] = artistsStrings
    }
    //https://www.raywenderlich.com/148515/grand-central-dispatch-tutorial-swift-3-part-2 code inspired from.
    let downloadGroup = DispatchGroup()
    DispatchQueue.global(qos: .userInitiated)
    let artistsArray = Array(artists.keys)
    DispatchQueue.concurrentPerform(iterations: (artistsArray.count)) {
        i in
        let index = Int(i)
        let key = artistsArray[index]
        let artistsStrings = Array(artists.values)[index]
        
        for artistString in artistsStrings {
            if let url = URL(string:"https://itunes.apple.com/search?term=\(artistString)") {
                
                
                downloadGroup.enter()
                Networker.sharedNetworker.urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                    guard error == nil else {
                        return
                    }
                    guard let realDate = data else {
                        return
                    }
                    if let outerDictionary = try? JSONSerialization.jsonObject(with: realDate, options: .init(rawValue: 0)) as? [String:Any] {
                        
                        if let innerArrays = outerDictionary?["results"] as? [[String:Any]] {
                            let artist = Artist(name: artistString)
                            for track in innerArrays {
                                let track = Track(withJSON: track, andArtist: artist)
                                artist.addToTracks(track)
                            }
                        }
                        
                    }
                    
                    
                    downloadGroup.leave()
                }).resume()
            }
            
        }
        
    }
    downloadGroup.notify(queue: DispatchQueue.main) { [weak self] in
        self?.delegate?.dataIsReady()
    }
}
}
