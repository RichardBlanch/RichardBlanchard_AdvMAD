//
//  JournalViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/22/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
enum JournalInputError: Error {
    case missingInput(indexPath:IndexPath)
}

class JournalViewController: UIViewController {
    var textFields = [UITextField]()
    //MARK: - Properties
    var workout:Workout? {
        didSet {
            if let masterSets =  workout?.masterSetsAsArray {
                 self.exerises = (masterSets.flatMap {$0.exercisesAsArray}).flatMap {$0.flatMap{$0}};
            }
           
        }
    }
    var exerises:[Exercise]?
    fileprivate let cellIdentifier = "cellIdentifier"
    var dictOfLabelsAndText = NSMutableDictionary()
    
    //MARK: - Outlets
    @IBOutlet weak fileprivate var workoutLabel:UILabel! {
        didSet {
            if let workoutName = workout?.name {
                workoutLabel.text = workoutName
            }
        }
    }
    @IBOutlet weak fileprivate var creatorLabel:UILabel! {
        didSet {
            if let workoutCreator = workout?.creator {
                creatorLabel.text = workoutCreator
            }
        }
    }
    @IBOutlet weak fileprivate var tableView:UITableView!
    
    
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
        if exercise == nil {
            /*
            Alerter.giveAlertForJournal(withTitle: "Add Entry", withMessage: "Add To Journal", fromViewController: self)
            */
        } else {
            /*
            Alerter.giveAlertForJournal(withTitle: "Missing Input", withMessage: "\(exercise?.name ?? "") is missing an input", fromViewController: self)
            exercise = nil
            */
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
        guard let exercises = exerises?[section] else {
            return 0
        }
        guard let setsCount = Int(exercises.sets!) else {
            return 0
        }
        return setsCount
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let exercises = self.exerises else {
            return 0
        }
        return exercises.count
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
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let exercises = self.exerises else {
            return nil
        }
        return exercises[section].name
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
        
        
    }
    
}


