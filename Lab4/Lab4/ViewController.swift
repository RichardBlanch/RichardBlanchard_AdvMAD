//
//  ViewController.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/15/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
     var fetchedResultsController : NSFetchedResultsController<Track>!
     let artistHelper = ArtistHelper()

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeSong" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let track = fetchedResultsController.object(at: indexPath!)
            let destVC = segue.destination.contents as! SongDetailViewController
            destVC.songClicked = track
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if itemsInCoreData() == false {
            artistHelper.delegate = self
            artistHelper.normalizeData()
        }
        fetchStuffFromCoreData()
        navigationItem.title = "Jamz"
        
        
    }
    func fetchStuffFromCoreData() {
        let fetchRequest: NSFetchRequest<Track> = Track.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Track.artist.name), ascending: true),NSSortDescriptor(key: #keyPath(Track.trackCensoredName), ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: ArtistService.sharedCellarService.managedObjectContext,
                                                              sectionNameKeyPath: #keyPath(Track.artist.name),
                                                              cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
    }
    func itemsInCoreData()->Bool {
        let fetchRequest: NSFetchRequest<Artist> = Artist.fetchRequest()
        
        do {
            let count = try ArtistService.sharedCellarService.managedObjectContext.count(for: fetchRequest)
            if count == 0 {
                return false
            } else {
                return true
            }
            
        } catch let error as NSError {
            return false
            print("Count not fetch \(error), \(error.userInfo)")
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController?.sections else {
            return 0
        }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = fetchedResultsController.object(at: indexPath).trackCensoredName
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections?[section]
        return sectionInfo?.name
    }
    
}



// MARK: - NSFetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            print("update")
            
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default: break
        }
    }
}
extension ViewController:ItunesAPIDidFinishLoading {
    func dataIsReady() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            try! ArtistService.sharedCellarService.managedObjectContext.save()
        }
    }
}

