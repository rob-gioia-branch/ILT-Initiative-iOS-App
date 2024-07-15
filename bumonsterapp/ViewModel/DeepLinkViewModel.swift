//
//  DeepLinkViewModel.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 10/07/24.
//

import Foundation
import SwiftUI
import BranchSDK

class DeepLinkViewModel: ObservableObject {
    @Published var shareUrl: String? {
        didSet{
            dataBinding()
        }
    }
    var dataBinding : (() -> ()) = {}
    
    func createDeepLink(product: Product) {
        // Branch.io - Set Branch Universal Object for product
        let buo: BranchUniversalObject = BranchUniversalObject(canonicalIdentifier: "item/12345")
        buo.title = product.title
        buo.contentDescription = product.subtitle
        buo.imageUrl = "https://branch.io/img/logo-dark.svg"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.canonicalUrl = "bu-monsters://product/\(product.productId)"
        
        // Branch.io - Set Deep Link Properties

        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.channel = "In-app"
        lp.feature = "sharing"
        lp.campaign = "messaging"
        lp.addControlParam("$desktop_url", withValue: "https://help.branch.io/")
        lp.addControlParam("$ios_url", withValue: "https://help.branch.io/developers-hub/docs/ios-sdk-overview")
        lp.addControlParam("$android_url", withValue: "https://help.branch.io/developers-hub/docs/android-sdk-overview")
        lp.addControlParam("$canonical_url", withValue: "https://www.branch.io/\(product.productId)")

        buo.getShortUrl(with: lp) { url, error in
            self.shareUrl = url! + "?monsterId=\(product.productId)"
        }
    }    

    func createDeepLink() {
        // Branch.io - Set Branch Universal Object for product
        let buo = BranchUniversalObject()
            buo.canonicalIdentifier = "item/12345"
            buo.canonicalUrl = "bu-monsters://section/path?param1=value1&param2=value2"
            buo.title = "Example Content Title"
            buo.contentDescription = "Example Content Description"
            buo.imageUrl = "https://www.example.com/image.png"
            buo.publiclyIndex = true
            buo.locallyIndex = true
        
        let lp = BranchLinkProperties()
            lp.channel = "referral"
            lp.feature = "referrals"
            lp.addControlParam("$desktop_url", withValue: "https://www.example.com")
            
            // OG tags to Customize link appearance
            lp.addControlParam("$og_title", withValue: "Content Title")
            lp.addControlParam("$og_description", withValue: "Content Description")
            lp.addControlParam("$og_image_url", withValue: "https://www.branch.com/logo.png")
            
            // Set unique promo code in a key to reward the referred user
            lp.addControlParam("promo_code", withValue: "PROMO123")
            
            // Set user ID of referring user in a key
            lp.addControlParam("referring_user_id", withValue: "user123")
            
            // Set “type” to 1 to make link one-time use
//            lp.addControlParam("type", withValue: "1")
            
        buo.getShortUrl(with: lp) { url, error in
                guard error == nil, let url = url else {
                    print("Error generating short URL: \(String(describing: error))")
                    return
                }
                
                print("Generated URL: \(url)")
                
                let shareText = "Check out this content: \(url)"
                
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first,
                   let rootViewController = window.rootViewController {
                    
                    let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = window
                    
                    rootViewController.present(activityViewController, animated: true) {
                        // Branch’s share-sheet tracks “share started” & “share completed” events
                        print("Share sheet presented")
                    }
                }
            }
        
        
//        buo.getShortUrl(with: lp) { url, error in
//            self.shareUrl = url!
//        }
    }
}
