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
        if let url = URL(string:"https://docs.google.com/forms/d/1-cqkGx8NKSXhEg9VvDFqlSnoEuwTxk8EDoeyJ3CR858/prefill") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
