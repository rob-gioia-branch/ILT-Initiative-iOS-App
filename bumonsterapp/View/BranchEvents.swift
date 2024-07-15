//
//  BranchEvents.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 16/07/24.
//

import Foundation
import UIKit
import BranchSDK
import SwiftUI

class BranchEvents: ObservableObject {
    // Commerce events
    static let ADD_TO_CART = BranchStandardEvent.addToCart
    static let PURCHASE = BranchStandardEvent.purchase
    
    // Content events
    static let VIEW_ITEMS = BranchStandardEvent.viewItems
    static let VIEW_ITEM = BranchStandardEvent.viewItem
    static let SHARE = BranchStandardEvent.share
    
    // Lifecycle events
    static let COMPLETE_REGISTRATION = BranchStandardEvent.completeRegistration
    static let LOGIN = BranchStandardEvent.login
    
    // Custom events
    static let REFER_A_FRIEND = "REFER_A_FRIEND"
    static let CONTINUE_AS_GUEST = "CONTINUE_AS_GUEST"
    static let LOGOUT = "LOGOUT"
    
    func trackPurchaseEvent() {
        let branchEvent = BranchEvent(name: BranchEvents.PURCHASE.rawValue)
        branchEvent.revenue = 120.0
        branchEvent.coupon = "coupon_code"
        branchEvent.logEvent { success, error in
            if success {
                print("Purchase event logged successfully")
            } else if let error = error {
                print("Failed to log purchase event: \(error.localizedDescription)")
            }
        }
    }

    func trackAddToCartEvent() {
        let branchEvent = BranchEvent(name: BranchEvents.ADD_TO_CART.rawValue)
        branchEvent.currency = .EUR
        branchEvent.eventDescription = "Customer added item to cart"
        branchEvent.revenue = 120.0
        branchEvent.coupon = "coupon_code"
        branchEvent.logEvent { success, error in
            if success {
                print("Add to cart event logged successfully")
            } else if let error = error {
                print("Failed to log add to cart event: \(error.localizedDescription)")
            }
        }
    }

    func trackStandardEvent(branchStandardEvent: BranchStandardEvent) {
        let branchEvent = BranchEvent(name: branchStandardEvent.rawValue)
        branchEvent.logEvent { success, error in
            if success {
                print("\(branchStandardEvent.rawValue) event logged successfully")
            } else if let error = error {
                print("Failed to log \(branchStandardEvent.rawValue) event: \(error.localizedDescription)")
            }
        }
    }

    func trackCustomEvent(customEventName: String) {
        let branchEvent = BranchEvent(name: customEventName)
        branchEvent.logEvent { success, error in
            if success {
                print("\(customEventName) event logged successfully")
            } else if let error = error {
                print("Failed to log \(customEventName) event: \(error.localizedDescription)")
            }
        }
    }
}
