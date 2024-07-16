//
//  WebViewController.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 15/07/24.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and configure the web view
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        // Load the desired URL
        if let url = URL(string: "https://branchmetrics.typeform.com/to/TAj1kdCc") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
