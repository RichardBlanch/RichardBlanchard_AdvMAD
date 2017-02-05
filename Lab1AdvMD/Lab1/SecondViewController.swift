//
//  SecondViewController.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/27/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController {
    let cellID = "bookStoreCell"
    let bookStores = BookStore.createBookStores()

    @IBOutlet weak var bookStoreTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Book Stores"
    }
}
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookStores.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BookStoreTableViewCell
        cell.bookStore = bookStores[indexPath.row]
        if let location = LocationService.sharedInstance.currentLocation {
            cell.location = location
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookStore = bookStores[indexPath.row]
        let latitudeOfBookStore = bookStore.location.coordinate.latitude
        let longitudeOfBookStore = bookStore.location.coordinate.longitude
        guard let location = LocationService.sharedInstance.currentLocation else {
            return
        }
        let directionsURL = URL(string:"http://maps.apple.com/?saddr=\(location.coordinate.latitude),\(location.coordinate.longitude)&daddr=\(latitudeOfBookStore),\(longitudeOfBookStore)")!
        UIApplication.shared.open(directionsURL, options: [:], completionHandler: nil)
    }
}


