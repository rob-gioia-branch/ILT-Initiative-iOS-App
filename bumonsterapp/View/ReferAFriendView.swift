//
//  ReferAFriendView.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

struct ReferAFriendView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var deepLinkVM: DeepLinkViewModel = DeepLinkViewModel()

    @State private var isShareSheetPresented = false
    @State private var shareLink: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            //BackButton { dismiss() }
            Spacer()
                .frame(height: 20)
            HStack {
                Spacer()
                AppLogo()
                Spacer()
            }
            Spacer()
                .frame(height: 30)
            Text("Branch University MonsterApp")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Monsters of every type to delight and cause a smile")
            ThemeButton(title: "Refer a friend") {
                branchEventReferAFriend()

                //TODO: Add action
                deepLinkVM.createDeepLink()
                deepLinkVM.dataBinding = {
                    self.isShareSheetPresented.toggle()
                }
            }.sheet(isPresented: $isShareSheetPresented) {
                ActivityViewController(activityItems: ["Refer to this code for a cool app: \(deepLinkVM.shareUrl ?? "")"])
            }
            Spacer()
        }
        .ignoresSafeArea()
        .padding(.horizontal, 30)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Constants.Colors.appBackground)
        .navigationBarBackButtonHidden()
    }

}

struct ReferAFriendView_Previews: PreviewProvider {
    static var previews: some View {
        ReferAFriendView()
    }
}
