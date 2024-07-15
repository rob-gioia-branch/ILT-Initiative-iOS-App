//
//  ShareView.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 11/07/24.
//

import Foundation
import SwiftUI

struct ShareView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var branchEvents = BranchEvents()

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            branchEvents.trackStandardEvent(branchStandardEvent: BranchStandardEvent)
        }
        .ignoresSafeArea()
        .padding(.horizontal, 30)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Constants.Colors.appBackground)
        .navigationBarBackButtonHidden()
    }

}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
