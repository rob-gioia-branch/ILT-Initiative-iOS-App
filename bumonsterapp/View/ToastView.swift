//
//  ToastView.swift
//  bumonsterapp
//
//  Created by Ravi Teja Akarapu on 11/07/24.
//

import SwiftUI
import Foundation

struct ToastView: View {
    var message: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding([.bottom, .trailing], 16)
                    .onTapGesture {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        .transition(.move(edge: .bottom))
    }
}
