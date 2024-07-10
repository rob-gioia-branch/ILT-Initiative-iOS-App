//
//  ActivityViewController.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 10/07/24.
//

import Foundation
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // customize the appearance or handle updates here
    }
}
