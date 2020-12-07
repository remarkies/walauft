//
//  CustomButton.swift
//  walauft-ios
//
//  Created by Luka Kramer on 07.12.20.
//

import SwiftUI

struct CustomButton: View {
    var icon: String
    var text: String
    var accent: Color
    var action: ()->() = { }
    
    var body: some View {
        Button (action: action) {
            Spacer()
            Image(systemName: icon).font(.system(size: 16, weight: .regular))
            Text("\(text)")
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(accent)
        .foregroundColor(Color("Foreground"))
        .cornerRadius(3)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(icon: "map", text: "Open in Maps", accent: Color("Accent1"), action: {})
    }
}
