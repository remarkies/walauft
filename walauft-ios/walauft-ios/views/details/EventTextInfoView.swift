//
//  EventTextInfoView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.12.20.
//

import SwiftUI

struct EventTextInfoView: View {
    var title: String
    var text: String
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(title)")
                .bold()
            Text("\(text)")
        }
    }
}

struct EventTextInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EventTextInfoView(title: "Event", text: "The Professor & his One Man Dirty Rhythm and Blues Explosion!")
    }
}
