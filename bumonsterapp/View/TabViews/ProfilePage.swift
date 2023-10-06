//
//  ProfilePage.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI
import BranchSDK
import UserNotifications

struct ProfilePage: View {
    @State private var showReferAFriendView = false
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 50)
                Text("Hello, \(userName ?? "")")
                    .font(.system(size: 25, weight: .bold))
                Spacer().frame(height: 40)
                Image(systemName: "person.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color(UIColor.lightGray))
                    .scaledToFit()
                Text(userName ?? "")
                    .font(.system(size: 18, weight: .medium))

                ThemeButton(title: "Refer a friend") {
                    //Show refer a friend screen
                    //showReferAFriendView = true
                    branchEventReferAFriend()
                    print("The user clicked on Refer a Friend")
                }
                ThemeButton(title: "Logout") {
                    loginData.Logout()
                    branchEventLogout()
                    print("The user has logged out")
                }
                Spacer()
            }
            .ignoresSafeArea()
            .padding()
            .frame(maxWidth: .infinity)
            .background(Constants.Colors.appBackground)
            .navigationDestination(isPresented: $showReferAFriendView) {
                ReferAFriendView()
            }
        }
    }

    var userName: String? {
        loginData.loggedInUserName
    }
}

// Branch.io - Track Event - User Logout
func branchEventLogout(){
    // Create a BranchEvent:
    let event = BranchEvent.customEvent(withName: "Logout")

    // Add relevant event data:
    event.alias            = "Logout"
    event.eventDescription = "User Logout"
    event.logEvent() // Log the event.
}

// Branch.io - Track Event - Refer a Friend
func branchEventReferAFriend(){
    // Create a BranchEvent:
    let event = BranchEvent.customEvent(withName: "REFER_A_FRIEND")

    // Add relevant event data:
    event.alias            = "Refer a Friend"
    event.eventDescription = "Refer a Friend"
    event.logEvent() // Log the event.
}


struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}


