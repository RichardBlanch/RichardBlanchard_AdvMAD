//
//  FirstViewController.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/27/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController {
    var authors:[Author]?
    @IBOutlet weak var statesPickerView: UIPickerView!
    var selectedRow = 0
    var selectedBook:Books!
    var selectedAuthor:Author!
    private let segueToBooksDetail = "goToBooksDetail"
    private let navBarTitle = "Choose Book"
    

    @IBAction func getFact(_ sender: UIButton) {
        performSegue(withIdentifier: segueToBooksDetail, sender: self)
    }
    @IBOutlet weak var stateInformationTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navBarTitle
        authors = Books.getBooks()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToBooksDetail {
            let destVC = segue.destination as! BookDetailViewController
            destVC.selectedBook = self.selectedBook ?? authors?[0].books[0]
            
        }
    }
}
extension FirstViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (authors?.count)!
        } else {
            return authors![selectedRow].books.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return authors?[row].name
        } else {
            return authors![selectedRow].books[row].title
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedRow = 0
            statesPickerView.selectRow(0, inComponent: 1, animated: true)
            statesPickerView.reloadComponent(1)
            selectedRow = row
        } else {
            //statesPickerView.reloadComponent(1)
            self.selectedBook = authors![selectedRow].books[row]
        }
    }
}

