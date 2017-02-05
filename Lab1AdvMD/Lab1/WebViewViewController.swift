//
//  WebViewViewController.swift
//  Lab1
//
//  Created by Rich Blanchard on 1/29/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController,WKUIDelegate {
    var webView: WKWebView!
    var book:Books!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: book.buyLink)
        webView.load(myRequest)

    }
    



}
