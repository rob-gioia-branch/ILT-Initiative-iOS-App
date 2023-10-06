//
//  AppLogo.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

struct AppLogo: View {
    var body: some View {
        Image("monster_app_logo")
            .resizable()
            .frame(width: 300, height: 50)
            .scaledToFit()

    }
}

struct AppLogo_Previews: PreviewProvider {
    static var previews: some View {
        AppLogo()
    }
}
