//
//  EventPlaceView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct EventPlaceView: View {
    var place: String
    var body: some View {
        Text("\(self.place)")
            .bold()
            .textCase(.uppercase)
            .font(.system(size: 16))
    }
}

struct EventPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        EventPlaceView(place: "Hive")
    }
}
