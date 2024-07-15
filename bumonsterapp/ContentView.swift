//
//  ContentView.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI
import BranchSDK
import AppTrackingTransparency
import AdSupport

struct ContentView: View {

    // Log Status..
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group {
            if log_Status {
                MainPage()
            } else {
                OnBoardingPage()
            }
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                if (status == .authorized) {
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier
                    print("IDFA: " + idfa.uuidString)
                } else {
                    print("Failed to get IDFA")
                }
                // Branch.io - Track ATT Opt-In and Opt-Out
                Branch.getInstance().handleATTAuthorizationStatus(status.rawValue)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
