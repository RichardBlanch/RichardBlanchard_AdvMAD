//
//  PlayerDetailViewController.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/30/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    @IBOutlet weak var nameTextLabel: UILabel! {
        didSet {
            nameTextLabel.text = player.name
        }
    }
    @IBOutlet weak var positionLabel: UILabel! {
        didSet {
            positionLabel.text = player.position
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.text = player.age
        }
    }
    @IBOutlet weak var heightLabel: UILabel! {
        didSet {
            heightLabel.text = player.height
        }
    }
    @IBOutlet weak var weightLabel: UILabel! {
        didSet {
            weightLabel.text = "180 lbs"
        }
    }
    @IBOutlet weak var throwsLabel: UILabel! {
        didSet {
            throwsLabel.text = player.throwingHand
        }
    }
    @IBOutlet weak var batsLabel: UILabel! {
        didSet {
            batsLabel.text = player.battingHand
        }
    }
    var player:Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.title = player.team?.teamName
    }
}
