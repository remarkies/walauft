//
//  HideKeyBoard.swift
//  walauft-ios
//
//  Created by Luka Kramer on 13.12.20.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
