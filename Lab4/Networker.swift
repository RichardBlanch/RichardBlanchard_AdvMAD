//
//  Networker.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/15/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

class Networker: NSObject {
    static let sharedNetworker = Networker()
    var urlSession:URLSession!
    private override init() {
        super.init()
        urlSession = URLSession(configuration: .default)
    }
}
