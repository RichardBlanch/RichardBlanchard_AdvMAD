//
//  SongDetailViewController.swift
//  Lab4
//
//  Created by Rich Blanchard on 3/15/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import AVFoundation

class SongDetailViewController: UIViewController,AVAudioPlayerDelegate {
    var songClicked:Track?
    var avPlayer:AVPlayer!
    var avPlayerItem:AVPlayerItem?
    lazy var selected = false
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    override func viewDidLoad() {
       
        
         playAndPauseButton.setImage(UIImage(named: "Pause"), for: .selected)
       
        if let songClicked = songClicked {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let data = try? Data(contentsOf: URL(string:songClicked.artworkUrl30!)!) {
                    DispatchQueue.main.async {
                        self?.artworkImageView.image = UIImage(data: data)
                        self?.artistLabel.text = songClicked.artist?.name
                        self?.genreLabel.text = songClicked.primaryGenreName
                        self?.navigationItem.title = songClicked.trackCensoredName
                    }
                   
                }
                
            }
        }
    }
    @IBAction func userClickedPlay(_ sender: UIButton) {
        if let songClicked = songClicked, let url = (URL(string: songClicked.previewUrl!))  {
            if selected == false {
                playAndPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
                if avPlayerItem == nil {
                avPlayerItem = AVPlayerItem(url: url)
                avPlayer = AVPlayer(playerItem: avPlayerItem)
                    NotificationCenter.default.addObserver(self, selector: #selector(self.endSong(playerItem:)), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayerItem)
                    
                   
            }
                avPlayer.play()
                selected = true
            } else {
                avPlayer.pause()
                selected = false
            }
           
        }
    }
    func endSong(playerItem item:AVPlayerItem) {
        avPlayerItem = nil
        selected = false
         playAndPauseButton.setImage(UIImage(named: "Media-Controls-Play-icon"), for: .normal)
    }
    @IBAction func volumeChanged(_ sender: UISlider) {
        avPlayer?.volume = sender.value
    }
    


}
extension SongDetailViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
      
            if let ivc = secondaryViewController.contents as? SongDetailViewController, songClicked == nil {
                return true 
            } else {
                return false
            }
        }
    
    
}
extension UIViewController {
    var contents: UIViewController {
        if let navCont = self as? UINavigationController {
            return navCont.visibleViewController ?? self // I am a navcontroller
        } else {
            return self
        }
    }
}
