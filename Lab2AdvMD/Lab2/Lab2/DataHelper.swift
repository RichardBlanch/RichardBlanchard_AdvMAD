//
//  DataHelper.swift
//  Lab2
//
//  Created by Rich Blanchard on 2/13/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
struct DataPersistenceClass {
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        var url:URL?
        url = URL(fileURLWithPath: "") //create a blank path
        do {
            try url = urls.first?.appendingPathComponent("pokemon.plist")
        } catch {
            print("Error is \(error)")
        }
        return url!
    }
    
}
