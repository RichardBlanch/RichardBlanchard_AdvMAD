//
//  JournalViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/22/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import CoreData
enum JournalInputError: Error {
    case missingInput(indexPath:IndexPath)
}

class JournalViewController: UIViewController {
    var weight:Array<Array<String>>!
   
    
    var textFields = [UITextField]()
    //MARK: - Properties
    var workout:Workout? {
        didSet {
            if let masterSets =  workout?.masterSetsAsArray {
                 self.exerises = (masterSets.flatMap {$0.exercisesAsArray}).flatMap {$0.flatMap{$0}};
            }
           
        }
    }
    var journalEntry:JournalEntry? {
        didSet {
             self.journalExercises = journalEntry?.journalExercises
                
            }
    }
    var journalSets:Array<Array<JournalSets>>? {
        if let journalExercise = journalExercises {
            var newReps:Array<Array<JournalSets>> = []
            let reps = journalExercise.flatMap {$0.journalSets}
            for set in reps {
                var newJournalReps:Array<JournalSets> = []
                for rep in set {
                    newJournalReps.append(rep as! JournalSets)
                }
                newReps.append(newJournalReps)
            }
                return newReps
        }
            return nil
    }
    var journalReps:Array<Array<JournalReps>>? {
        if let journalExercise = journalExercises {
            var newReps:Array<Array<JournalReps>> = []
            let reps = journalExercise.flatMap {$0.journalReps}
            for set in reps {
                var newJournalReps:Array<JournalReps> = []
                for rep in set {
                    newJournalReps.append(rep as! JournalReps)
                }
                newReps.append(newJournalReps)
            }
                return newReps
        }
            return nil
    }
    
    var exerises:[Exercise]?
    var journalExercises:Array<JournalExercise>?
    fileprivate let cellIdentifier = "cellIdentifier"
    var dictOfLabelsAndText = NSMutableDictionary()
    var persistentContainer:NSPersistentContainer? = CoreDataStack.shared.persistentContainer
    
    //MARK: - Outlets
    @IBOutlet weak fileprivate var workoutLabel:UILabel! {
        didSet {
            if let workoutName = workout?.name {
                workoutLabel.text = workoutName
            }
            if let journalWorkoutName = journalEntry?.name {
                workoutLabel.text = journalWorkoutName
            }
        }
    }
    @IBOutlet weak fileprivate var creatorLabel:UILabel! {
        didSet {
            if let workoutCreator = workout?.creator {
                creatorLabel.text = workoutCreator
            }
            if let journalWorkoutCreator = journalEntry?.creator {
                creatorLabel.text = journalWorkoutCreator
            }
        }
    }
    @IBOutlet weak fileprivate var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let count = exerises?.count {
              weight = [[String]](repeating: [String](repeating: "", count: 10), count:(count))
        } else {
            weight = [[String]](repeating: [String](repeating: "", count: 10), count:(10))
        }
      
    }
    
    
    //MARK: - Actions
    @IBAction func addWorkoutToJournal(sender: UIBarButtonItem) {
        
        var exercise:Exercise?
        DispatchQueue.global(qos: .userInteractive).sync {
            do {
                try checkIfAnyEmptyInputs()
            } catch JournalInputError.missingInput(indexPath: let indexPath) {
                exercise = exerises?[indexPath.section]
                
            } catch {
                
            }
            
        }
         if let context = persistentContainer?.viewContext {
            /*
        if exercise == nil {
            
            
                
            Alerter.giveAlertForJournal(withTitle: "Add Entry", withMessage: "Add To Journal", fromViewController: self, andContext: context)
 
        } else {
            
            Alerter.giveAlertForJournal(withTitle: "Missing Input", withMessage: "\(exercise?.name ?? "") is missing an input", fromViewController: self, andContext: context)
            exercise = nil
 
        }
 */
       
            do {
                cleanUpEmptyValues()
                
                let id = try? JournalEntry.findIDForJournalEntry()
                
                let _ = try JournalEntry.findOrCreateJournalEntry(inContext: context, fromWeightInputs:weight, withID: id!, withTitle: workoutLabel.text!, andCreator:creatorLabel.text!, andWorkoutNames: exerises!.flatMap {$0.name })
                
                weight = nil
                
                try context.save()
                
                performSegue(withIdentifier: "unwindToJournal", sender: self)
                
                
                
               
            } catch {
                assert(true == false, "Error adding Journal Entry")
            }
        }
        
    }
    //MARK: - Helper Functions
    func checkIfAnyEmptyInputs()throws {
        let sections = tableView.numberOfSections
        for section in 0..<sections {
            let rows = tableView.numberOfRows(inSection: section)
            for row in 0..<rows {
                let indexPath = IndexPath(item: row, section: section)
                if let cell = tableView.cellForRow(at: indexPath) as? JournalTableViewCell {
                    if  dictOfLabelsAndText.value(forKey: cell.setLabel.text!) == nil {
                        throw JournalInputError.missingInput(indexPath: indexPath)
                    }
                    else if dictOfLabelsAndText.value(forKey: cell.setLabel.text!) as! String == "" {
                         throw JournalInputError.missingInput(indexPath: indexPath)
                    }
                
                }
            }
        }
    }
    
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let exerises = exerises {
            if let setsCount = Int(exerises[section].sets!) {
                return setsCount
            } else {
                return 0
            }
    }
        if let journalExercises = journalExercises {
            
            if let journalSet = journalSets?[section] {
                return journalSet.count
            } else {
                return 0
            }
        }
        return 0
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let exercises = self.exerises  {
            return exercises.count
        }
        if let journalExercises = journalExercises {
            return journalExercises.count
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! JournalTableViewCell
        let prefixAlphabetNumber = getAlphabet(forSectionNumber: indexPath.section)
        cell.setLabel.text =  prefixAlphabetNumber + "Set  \(indexPath.row + 1)"
        cell.weightinputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
        let key = cell.setLabel.text!
        if dictOfLabelsAndText.value(forKey: key) != nil {
            cell.weightinputTextField.text = dictOfLabelsAndText.value(forKey: key) as! String?
           
        } else {
            cell.weightinputTextField.placeholder = "lbs"
            cell.weightinputTextField.text = ""
        }
        if let journalSets = journalSets?[indexPath.section][indexPath.row] {
            cell.weightinputTextField.text = "\(journalSets.weight)" + " " + "lbs"
        }
        cell.row = indexPath.row
        cell.section = indexPath.section
        
      
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let exercises = self.exerises {
            return exercises[section].name
        }
        if let journalExercises = self.journalExercises {
            return journalExercises[section].name
        }
        return ""
        
    }
    func getAlphabet(forSectionNumber sectionNumber:Int)->String {
        switch sectionNumber {
        case 0:
            return "A) "
        case 1:
            return "B) "
        case 2:
            return "C) "
        case 3:
            return "D) "
        case 4:
            return "E) "
        case 5:
            return "F) "
        case 6:
            return "G) "
        default: return "Z) "
            
        }
    }
}
extension JournalViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if let setLabel = textField.superview?.viewWithTag(100) as? UILabel {
            let textFieldText = textField.text
            dictOfLabelsAndText.setObject(textFieldText, forKey: setLabel.text as! NSCopying)
        }
        if let cell = textField.superview?.superview as? JournalTableViewCell {
            if var weight = weight {
                 self.weight[cell.section][cell.row].append(cell.weightInput!)
            }
           
        }
    }
    func cleanUpEmptyValues() {
        weight = weight.flatMap {$0.filter {$0 != ""}}
    }
    
}


