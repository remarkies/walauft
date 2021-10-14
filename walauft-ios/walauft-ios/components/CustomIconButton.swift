//
//  CustomIconButton.swift
//  walauft-ios
//
//  Created by Luka Kramer on 07.12.20.
//

import SwiftUI

struct CustomIconButton: View {
    var icon: String
    var background: Color
    var foreground: Color
    var isSelected: Bool
    var action: ()->() = { }
    var body: some View {
        Button (action: action) { 
            Image(systemName: icon).font(.system(size: 16, weight: .regular))
            Spacer()
        }
        .frame(width: 40, height: 40)
        .background(background)
        .foregroundColor(foreground)
        .cornerRadius(3)
        .shadow(radius: isSelected ? 2 : 0)
    }
}

struct CustomIconButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomIconButton(icon: "map", background: Color("Layer1"), foreground: Color("Foreground"), isSelected: true)
    }
}
