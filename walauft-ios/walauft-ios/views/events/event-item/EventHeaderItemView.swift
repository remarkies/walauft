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
            .bold()
            .textCase(.uppercase)
            .font(.system(size: 16))
    }
}

struct EventHeaderItemView_Previews: PreviewProvider {
    static var previews: some View {
        EventHeaderItemView(text: Text("text"))
    }
}
