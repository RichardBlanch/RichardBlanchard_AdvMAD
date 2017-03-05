//
//  StreetViewController.swift
//  Dogstagram
//
//  Created by Rich Blanchard on 2/28/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class StreetViewController: UICollectionViewController {
    var streetViewPlacesIHaveLived: [StreetView]? {
        willSet {
            places[0] = newValue
        }
    }
    var streetViewPlacesIHaveNotLived: [StreetView]? {
        willSet {
            places[1] = newValue
        }
    }
    lazy var places = [Int:[StreetView]]()
    var selectedStreetView:StreetView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Networker.sharedNetworker.delegate = self
        Networker.sharedNetworker.callApiToGetImage()
       

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.streetView = selectedStreetView
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return places.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return (places[section]?.count)!
       
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StreetViewCollectionCell
        cell.streetView = places[indexPath.section]?[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! HeaderView
            indexPath.section == 0 ? (headerView.labelText = "I have been here.") : (headerView.labelText = "I have not been here.")
           
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath)
            return footerView
        }
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       selectedStreetView = places[indexPath.section]?[indexPath.row]
        let newSize = CGSize(width: ((selectedStreetView.image?.size.width)! * 10), height: ((selectedStreetView.image?.size.height)! * 10))
        
        selectedStreetView.revampedImage = selectedStreetView.image?.makeImageBigger(withFrame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        
        performSegue(withIdentifier: "goToDetail", sender: self)
    }

}
extension StreetViewController: GetImageFromGoogleAPI {
    func getImagesFromGoogleAPI(withStreetView: [StreetView]) {
        
        
        streetViewPlacesIHaveLived = withStreetView.filter({ (streetView) -> Bool in
            streetView.haveLived == true
        })
       
        streetViewPlacesIHaveNotLived = withStreetView.filter({ (streetView) -> Bool in
            streetView.haveLived == false
        })
 
       
        
        OperationQueue.main.addOperation { 
             self.collectionView?.reloadData()
        }
    }
}
