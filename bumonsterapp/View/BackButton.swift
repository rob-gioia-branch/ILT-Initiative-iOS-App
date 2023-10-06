//
//  BackButton.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundColor(Color.black.opacity(0.7))
        }

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BackButton {
            
        }
    }
}
