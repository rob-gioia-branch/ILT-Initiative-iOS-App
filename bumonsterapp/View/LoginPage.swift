//
//  LoginPage.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI
import BranchSDK

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel
    @Environment (\.dismiss) var dismiss
    let uuid = UUID().uuidString
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack {
                    HStack {
                        BackButton { dismiss() }
                        Spacer()
                    }
                    .padding(.vertical, 50)
                    .padding(.horizontal)
                    Spacer()
                        .frame(height: 100)
                    AppLogo()
                    Spacer()
                        .frame(height: 50)
                    VStack(spacing: 20) {
                        ThemeTextField(placeholder: "username", isSecure: false, text: $loginData.email)
                        ThemeTextField(placeholder: "password", isSecure: true, text: $loginData.password)
                        ThemeButton(title: loginData.registerUser ? "Create account" : "Login") {
                            
                            if loginData.registerUser {
                                loginData.Register()
                                loginData.Login()
                                branchEventRegistration()
                                print("Branch Event Registration Complete")
                            }
                            else {
                                loginData.Login()
                                branchEventLogin()
                                print("Branch Event Login Complete")
                                Branch.getInstance().setIdentity(uuid)
                                print("The Branch user setIdentity is \(uuid)")
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .frame(minHeight: reader.size.height + 100)
                .padding(.horizontal)
                .background(Constants.Colors.appBackground)
                .navigationBarBackButtonHidden()
            }
            .ignoresSafeArea(.all)
        }
    }
}
// Branch.io - Track Event - User Login
func branchEventLogin(){
    // Create a BranchEvent:
    let event = BranchEvent.standardEvent(.login)
    // Add relevant event data:
    event.alias            = "User Login"
    event.eventDescription = "User has logged in"
    event.logEvent() // Log the event.
}

// Branch.io - Track Event - User Login
func branchEventRegistration(){
    // Create a BranchEvent:
    let event = BranchEvent.standardEvent(.completeRegistration)
    // Add relevant event data:
    event.alias            = "Create User Account"
    event.eventDescription = "User Has Created Account"
    event.logEvent() // Log the event.
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(loginData: LoginPageModel(registerUser: true))
    }
}

struct ThemeTextField: View {
    let placeholder: String
    let isSecure: Bool
    @Binding var text: String
    var body: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1)
                    )
        }
        else {
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1)
                    )
        }
    }
}
