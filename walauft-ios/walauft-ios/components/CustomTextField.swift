//
//  CustomTextField.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .font(.custom("Manrope-Medium", size: 12))
                    .foregroundColor(Color("SubtleForeground"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .font(.custom("Manrope-Medium", size: 12))
                .font(.system(size: 12))
                .foregroundColor(Color("Foreground"))
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            
            
        }
        .background(Color("Layer2"))
        .cornerRadius(5)
        .padding(.horizontal)
    }
}
