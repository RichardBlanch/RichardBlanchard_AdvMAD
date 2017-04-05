//
//  DetailViewController.swift
//  HackerNews
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var hackerNews:HackerNews?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            if let hackerNews = hackerNews {
                titleLabel.text = hackerNews.title
            }
        }
    }
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            if let hackerNews = hackerNews {
             authorLabel.text = hackerNews.by
            }
        }
    }

    @IBOutlet var starz: [UIImageView]! {
        
            didSet {
                if let hackerNews = hackerNews {
                    var score:Int = hackerNews.score
                    if score > 10 {
                        score = 10
                    }
                    for i in 0..<score {
                        starz[i].image = UIImage(named: "star_filled")
                    }
                }
        }
    }
    
   
}
