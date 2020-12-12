//
//  EventTextInfoView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.12.20.
//

import SwiftUI

struct EventTextInfoView: View {
    var title: String
    var text: Text
    var body: some View {
        VStack (alignment: .leading, spacing: 2) {
            Text("\(title)")
                .bold()
                .font(.system(size: 12))
                .foregroundColor(Color("Layer2"))
            
            text
                .font(.system(size: 16))
                .foregroundColor(Color("Foreground"))
                
        }
        .padding(.bottom, 12)
    }
}

struct EventTextInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EventTextInfoView(title: "Event", text: Text("The Professor & his One Man Dirty Rhythm and Blues Explosion!"))
    }
}
