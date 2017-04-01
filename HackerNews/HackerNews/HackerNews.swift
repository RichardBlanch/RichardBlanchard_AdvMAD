//
//  HackerNews.swift
//  HackerNews
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import Foundation

class HackerNews:NSObject {
    var title:String!
    var by:String!
    var url:String!
    var score:Int!
    
    init(withTitle title:String, byAuthor by:String, withURL url:String, andScore score:Int) {
        self.title = title
        self.by = by
        self.url = url
        self.score = score
    }
    init(dictionary:NSDictionary) {
        self.title = (dictionary.value(forKey: "title") as? String) ?? "No available title"
        self.by = (dictionary.value(forKey: "by") as? String) ?? "Anonymous"
        self.url = (dictionary.value(forKey: "url") as? String) ?? "no valid url"
        self.score = (dictionary.value(forKey: "score") as? Int) ?? -100
    }
    
    
    override init() {
        super.init()
    }
    override var description: String {
        return self.title
    }
    class func fetchHackerNews(completionHandler:@escaping(([HackerNews]?)->Void)) {
        var hackerNews = [HackerNews]()
        for i in 1...75 {
            let url = "https://hacker-news.firebaseio.com/v0/item/\(i).json?"
            let urlRequest = URLRequest(url: URL(string: url)!)
            
            Networker.shared.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    return
                }
                do {
                    if let data = data {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                        let hackerNew = HackerNews(dictionary: jsonData)
                        if hackerNew.title != "No available title" {
                             hackerNews.append(hackerNew)
                        }
                       
                        if hackerNews.count == 48 {
                            completionHandler(hackerNews)
                            return
                        }
                    }
                } catch {
                    completionHandler(nil)
                }
            }).resume()
        }
    }
}
