//
//  Author.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/29/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class Author: NSObject {
    var name:String!
    var books:[Books]!
    
    init(name:String,bookDictionaryArray:[[String:AnyObject]]) {
        var books:[Books] = []
        for book in bookDictionaryArray {
            var book = Books(dictionary: book)
            books.append(book)
        }
        self.books = books
        self.name = name
        super.init()
        for i in 0..<self.books.count {
            self.books[i].author = self
        }
    }

}
