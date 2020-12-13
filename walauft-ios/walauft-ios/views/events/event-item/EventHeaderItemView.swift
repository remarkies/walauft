//
//  EventHeaderItemView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct EventHeaderItemView: View {
    var text: Text
    var body: some View {
        self.text
            .font(.custom("Manrope-Bold", size: 16))
            .bold()
            .textCase(.uppercase)
            
    }
}

struct EventHeaderItemView_Previews: PreviewProvider {
    static var previews: some View {
        EventHeaderItemView(text: Text("text"))
    }
}
