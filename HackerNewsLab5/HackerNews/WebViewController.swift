//
//  WebViewController.swift
//  HackerNews
//
//  Created by Rich Blanchard on 3/23/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView:UIWebView! {
        didSet {
            if let hackerNews = hackerNews, let url = URL(string: hackerNews.url) {
                    let request = URLRequest(url: url)
                    webView.loadRequest(request)
            }
        }
    }
    @IBOutlet weak var spinner:UIActivityIndicatorView!
    var hackerNews:HackerNews?

}
extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
}
