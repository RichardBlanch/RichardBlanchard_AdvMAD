//
//  WebViewController.swift
//  Midterm_Rich_Blanchard
//
//  Created by Rich Blanchard on 3/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var selectedResort:SkiResorts!
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            let webRequest = URLRequest(url: URL(string: selectedResort.url)!)
            webView.loadRequest(webRequest)
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
}
extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
}
