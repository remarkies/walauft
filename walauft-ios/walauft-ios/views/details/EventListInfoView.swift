//
//  EventListInfoView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 07.12.20.
//

import SwiftUI

struct EventListInfoView: View {
    var title: String
    var texts: [String]
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(title)")
                .bold()
                .font(.custom("Manrope-Bold", size: 12))
                .foregroundColor(Color("Layer2"))
            ForEach(texts, id: \.self) {
                text in
            
                Text("\(text)")
                    .font(.custom("Manrope-Medium", size: 16))
                    .foregroundColor(Color("Foreground"))
            }
        }
        .padding(.bottom, 12)
    }
}

struct EventListInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EventListInfoView(title: "Adresse", texts: [
            "Some street 8",
            "Postcode, Town"
        ])
        .background(Color("Background"))
    }
}
