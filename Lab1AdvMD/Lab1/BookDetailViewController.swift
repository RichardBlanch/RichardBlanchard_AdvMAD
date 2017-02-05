//
//  BookDetailViewController.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/29/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var selectedBook:Books!
    private let segueToWebView = "findOnline"
    @IBOutlet weak var heightOfTextView: NSLayoutConstraint!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookDescriptionTextView: UITextView!
    
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet var favButtons: [UIButton]!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var activityIndicator:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = selectedBook.title
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        for i in 0..<favButtons.count {
            favButtons[i].alpha = 0
        }
        
        selectedBook.fetchData(fromAPIString: selectedBook.googleAPILink) { (updatedSelectedBook) in
            OperationQueue.main.addOperation({
               // self.activityIndicator.stopAnimating()
                self.bookImageView.image = updatedSelectedBook?.mainImage
                self.bookDescriptionTextView.text = updatedSelectedBook?.description
                
                self.setHeightForTextView()
                
                let intRating = Int((updatedSelectedBook?.averageRating)!)
                
                for i in 0..<5 {
                    self.favButtons[i].alpha = 1.0
                }
                
                for i in 0..<intRating {
                    self.favButtons[i].setImage(UIImage(named: "favorite-filled-button"), for: .normal)
                }
                
                self.spinner.stopAnimating()
                
                
            })
        }
    }
    func setHeightForTextView() {
        let sizeForTextView = bookDescriptionTextView.sizeThatFits(bookDescriptionTextView.frame.size)
        heightOfTextView.constant = sizeForTextView.height
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: bookDescriptionTextView.frame.origin.y + heightOfTextView.constant + 20)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToWebView {
            let vc = segue.destination as! WebViewViewController
            vc.book = selectedBook
        }
    }

    @IBAction func findOnline(_ sender: UIButton) {
        performSegue(withIdentifier: segueToWebView, sender: self)
    }
}
