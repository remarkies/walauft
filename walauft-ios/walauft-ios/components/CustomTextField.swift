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
            if text.isEmpty { placeholder.font(.system(size: 12)).textCase(.uppercase).padding(.horizontal, 40).padding(.vertical, 16) }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .textCase(.uppercase)
                .font(.system(size: 12))
                .foregroundColor(Color("Foreground"))
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .border(Color("Layer1"), width: 2)
                .padding(.horizontal, 24)
                
        }
    }
}
