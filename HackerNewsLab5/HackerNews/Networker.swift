//
//  Networker.swift
//  HackerNews
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class Networker: NSObject {
    static let shared = Networker()
    var urlSession:URLSession!
    
    private override init() {
        urlSession = URLSession(configuration: .default)
        super.init()
    }

}
