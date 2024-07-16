//
//  WebViewContainer.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 15/07/24.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string:"https://branchmetrics.typeform.com/to/TAj1kdCc") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
