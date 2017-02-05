//
//  States.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/27/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation
import Kanna
import Alamofire
import UIKit

class Books {
    var author:Author!
    var coverString:String!
    var year:String!
    var title:String!
    var amazonURL:String!
    var averageRating:Double!
    var description:String!
    var printedPageCount:Int!
    var imageURL:URL!
    var mainImage:UIImage!
    var buyLink:URL!
    var googleAPILink:String!
    init(dictionary:[String:AnyObject]) {
        self.coverString = dictionary["Cover"] as! String!
        self.year = dictionary["Year"] as! String!
        self.title = dictionary["Title"] as! String!
        self.amazonURL = dictionary["URL"] as! String
        self.googleAPILink = dictionary["googleAPILink"] as! String
    }
    private func addPropertiesFromJSON(jsonDictionary:[String:AnyObject])->Books {
        print(jsonDictionary)
        let description = jsonDictionary["volumeInfo"]?["description"] as? String ?? ""
        let averageRating = jsonDictionary["volumeInfo"]?["averageRating"] as? Double ?? 4.0
        let printedPageCount = jsonDictionary["volumeInfo"]?["printedPageCount"] as? Int ?? 350
        let buyLink = jsonDictionary["saleInfo"]?["buyLink"] as? String ?? "https://play.google.com/store/books/details?id=-A8zV0lVfEYC&rdid=book--A8zV0lVfEYC&rdot=1&source=gbs_api"
        
        if let imageLinks = jsonDictionary["volumeInfo"]!["imageLinks"] as? [String:AnyObject] {
        let largeImage = imageLinks["large"] as? String ?? imageLinks["thumbnail"] as! String
        let largeImageURL = URL(string: largeImage)
        self.imageURL = largeImageURL
        }
        if self.imageURL == nil {
            self.imageURL = URL(string: "http://books.google.com/books/content?id=6xpePwAACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE71oN0qyFXUXlgp86ICayxdIDaX5D3JXLs1Ti6hdYtRgAGX8VAj6ZDOQxjQjxyhdt-7-37434jTtfy70BiDv7QbyRIDC0Je33aDLXuOG4IvfhyJzcdIRqbNYzJ7uyZzDNDJSrwRA&source=gbs_api")
        }
        
        self.description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        self.averageRating = averageRating
        self.printedPageCount = printedPageCount
        
        self.buyLink = URL(string: buyLink)
       
        return self
      
        
    }
    static func getBooks()->[Author]? {
    var authors:[Author] = []
    guard let path = Bundle.main.path(forResource: "Books", ofType: "plist") else {
        return nil
    }
    guard let arrayRoot = NSArray(contentsOfFile: path) else {
        return nil
    }
        for dictionary in arrayRoot as! [[String:AnyObject]] {
            
            let authorString = dictionary["Author"] as! String
            let books = dictionary["Books"] as! [[String:AnyObject]]
            let author = Author(name: authorString, bookDictionaryArray: books)
            authors.append(author)
        }
   
    return authors
    }
    func getImage()->UIImage? {
        return UIImage(named: coverString)
    }
    func fetchData(fromAPIString string:String, completionHandler:@escaping ((Books?)->Void)) {
        URLSession.shared.dataTask(with: URL(string: string)!) { (data, response, error) in
            guard error == nil else {
                return
            }
            do {
                let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as! NSDictionary
                let book = self.addPropertiesFromJSON(jsonDictionary: data as! [String : AnyObject])
                do {
                    let data =  try Data(contentsOf: book.imageURL)
                    book.mainImage = UIImage(data: data)
                    completionHandler(book)
                } catch let convertURLError as NSError {
                    completionHandler(nil)
                }
                
                
                
            }catch let error as NSError {
                completionHandler(nil)
                print(error)
                
            }
            }.resume()
    }
}

