//
//  ThemeButton.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

struct ThemeButton: View {
    let title: String
    let height: CGFloat
    let fontSize: CGFloat
    let weight: Font.Weight
    let disabled: Bool
    let action: () -> Void

    init(title: String, fontSize: CGFloat = 20, height: CGFloat = 50, weight: Font.Weight = .bold , disabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.height = height
        self.fontSize = fontSize
        self.weight = weight
        self.action = action
        self.disabled = disabled
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: height)
                .foregroundColor(.white)
                .font(.system(size: fontSize, weight: weight))
                .background(disabled ? Color(UIColor.lightGray) : Constants.Colors.themeBlue)
                .clipShape(
                    Capsule()
                )
        }.disabled(disabled)
    }
}

struct ThemeButton_Previews: PreviewProvider {
    static var previews: some View {
        ThemeButton(title: "Hit me!") {}
    }
}
