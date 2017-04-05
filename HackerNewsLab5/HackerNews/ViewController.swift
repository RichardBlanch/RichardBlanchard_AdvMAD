//
//  ViewController.swift
//  HackerNews
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private let cellIdentifier = "Cell"
    var news:[HackerNews]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var disclosureHackerNewsTapped:HackerNews! {
        didSet {
            self.performSegue(withIdentifier: "disclosure", sender: self)
        }
    }
    
    override func viewDidLoad() {
       HackerNews.fetchHackerNews {[weak self] (hackerNews) in
        if let hackerNews = hackerNews {
                self?.news = hackerNews
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = news?.count else {
            return 0
        }
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let hackerNews = news?[indexPath.row]
        cell.textLabel?.text = hackerNews?.title
        cell.detailTextLabel?.text = hackerNews?.by
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "go":
                let destVC = segue.destination as! WebViewController
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let hacker = news?[indexPath.row]
                    destVC.hackerNews = hacker
                }
                case "disclosure":
                    let destVC = segue.destination as! DetailViewController
                    destVC.hackerNews = self.disclosureHackerNewsTapped
            default:
                fatalError("This shouldn't happen")
            }
        }
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
         disclosureHackerNewsTapped = news?[indexPath.row]
        
    }
}

