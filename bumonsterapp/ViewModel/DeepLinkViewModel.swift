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
        buo.canonicalUrl = "https://www.branch.io/\(product.productId)"
        
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
}
