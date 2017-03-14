//
//  SortViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/21/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    static let collectionViewIdentifier = "SortByIndentifier"
    private let cancelSegue = "cancelFromFilter"
    private let doneSegue = "doneFromFilter"
    let dataForCollectionView = Workout.getStaticImagesAndTextForCollectionView()
    var waysToFilterWorkoutsBy = [String]()
    weak var delegate:FilterWorkoutsDelegate?
    @IBOutlet weak var removeAllButton:UIButton!
    
    @IBAction func didHitCancel(_ sender: Any) {
        performSegue(withIdentifier: cancelSegue, sender: self)
    }
    
    @IBAction func didHitDone(_ sender: Any) {
        delegate?.wantsToFetchWorkoutsWith(withFilterArray: waysToFilterWorkoutsBy)
        performSegue(withIdentifier: doneSegue, sender: self)
    }
    @IBAction func clearAllFilters(_ sender: RemoveAll) {
        let items = collectionView.numberOfItems(inSection: 0)
        for i in 0..<items {
            let indexPath = IndexPath(item: i, section: 0)
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.alpha = 1.0
        }
        waysToFilterWorkoutsBy.removeAll()
    }
    
    
}
extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForCollectionView!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterViewController.collectionViewIdentifier, for: indexPath) as! WorkoutFilterByCollectionViewCell
        cell.imageWithBodyType = dataForCollectionView?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if cell.alpha == 1.0 {
                cell.alpha = 0.55
                 waysToFilterWorkoutsBy.append((dataForCollectionView?[indexPath.row].1)!)
            } else {
                cell.alpha = 1.0
                guard let stringToRemove = dataForCollectionView?[indexPath.row].1 else {
                    return
                }
                if let index = waysToFilterWorkoutsBy.index(of: stringToRemove) {
                    waysToFilterWorkoutsBy.remove(at: index)
                }
            }
        }
       
    }
}
