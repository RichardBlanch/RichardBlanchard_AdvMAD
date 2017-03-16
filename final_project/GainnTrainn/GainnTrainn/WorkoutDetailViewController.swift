//
//  WorkoutDetailViewController.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    

  
    var workoutSelected:Workout!
    let setCell = "SetCell"
    
    
    @IBOutlet weak var tableView: UITableView!
    private var tableHeaderHeight:CGFloat!
    @IBOutlet weak var headerView: WorkoutHeaderView!
    fileprivate weak var addToJournalOrCalendarView:AddToView? {
        willSet {
            if newValue == nil {
                addToJournalOrCalendarView?.removeFromSuperview()
            }
        }
    }
    
    @IBAction func addToCalendarOrJournal(_ sender: UIBarButtonItem) {
        
        if let addToJournalOrCalendarView = addToJournalOrCalendarView {
            // do nothing
        } else { //create
            addToJournalOrCalendarView = AddToView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            addToJournalOrCalendarView?.delegate = self
            tableView.isUserInteractionEnabled = false
            self.view.addSubview(addToJournalOrCalendarView!)
        }
        
    }
    @IBAction func choseWorkoutFromCalendarSegue(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
        setUpUI(isFirstTime: false)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI(isFirstTime: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        addToJournalOrCalendarView = nil
    }
    override func viewWillDisappear(_ animated: Bool) {
        if addToJournalOrCalendarView != nil {
            addToJournalOrCalendarView?.removeFromSuperview()
            tableView.isUserInteractionEnabled = true
        }
    }
    func setUpUI(isFirstTime:Bool) {
        tableHeaderHeight = workoutSelected.aspectRatio * UIScreen.main.bounds.size.width
        headerView.imageForWorkout = workoutSelected.mainImage
        headerView.workoutCreatorText = workoutSelected.creator
        navigationItem.title = workoutSelected.name
        if isFirstTime {
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        }
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        headerView.imageForWorkout = workoutSelected.mainImage
        updateHeaderView()
    }
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        if tableView.contentOffset.y < -tableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
        
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Calendar" {
            let destVC = segue.destination as! CalendarViewController
            destVC.workoutSelected = workoutSelected
        }
    }
    
}
extension WorkoutDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (workoutSelected.masterSetsAsArray?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let masterSet = workoutSelected.masterSetsAsArray?[section]
        return (masterSet?.exercisesAsArray?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: setCell, for: indexPath)
        let exercise = workoutSelected.masterSetsAsArray?[indexPath.section].exercisesAsArray?[indexPath.row]
        cell.textLabel?.text = exercise?.name
        cell.detailTextLabel?.text = "\(exercise?.sets ?? "") X \(exercise?.reps ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let count = workoutSelected.masterSetsAsArray?[section].exercisesAsArray?.count else {
            return ""
        }
        return workoutSelected.getSetName(forCount: count)
    }
}
extension WorkoutDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
extension WorkoutDetailViewController: AddToViewDelegate {
    func addToViewButtonTapped(fromButton button:AddToViewButtonTapped) {
        switch button {
            
        case .journal,.calendar:
            performSegue(withIdentifier: button.rawValue, sender: self)
            
        case .cancel:
            addToJournalOrCalendarView?.fallOffScreen {[weak self] in
                self?.tableView.isUserInteractionEnabled = true
                self?.addToJournalOrCalendarView?.removeFromSuperview()
                self?.addToJournalOrCalendarView = nil
            }
            
        }
    }
}

