//
//  EventTimeView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct EventTimeView: View {
    var time: String
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(self.time)")
                .bold()
                .font(.system(size: 16))
        }
    }
}

struct EventTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EventTimeView(time: "20:00")
    }
}
