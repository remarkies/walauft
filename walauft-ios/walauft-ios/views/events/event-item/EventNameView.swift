//
//  EventNameView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct EventNameView: View {
    var name: String
    var body: some View {
        Text("\(self.name)")
                .font(.system(size: 12))
    }
}

struct EventNameView_Previews: PreviewProvider {
    static var previews: some View {
        EventNameView(name: "Mad Catz")
    }
}
