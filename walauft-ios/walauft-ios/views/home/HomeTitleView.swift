//
//  HomeTitleView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI

struct HomeTitleView: View {
    var fontSize: CGFloat

    var body: some View {
        HStack (alignment: .top) {
            VStack {
                Text("IN")
                .font(.custom("Manrope-Bold", size: self.fontSize))
                .bold()
                .textCase(.uppercase)
                .foregroundColor(Color("Layer1"))
                Spacer()
            }
            .padding(.leading, 10)
            Spacer()
            HStack {
                Spacer()
                Text("Walauft")
                    .font(.custom("Manrope-Bold", size: self.fontSize))
                    .bold()
                    .textCase(.uppercase)
                    .foregroundColor(Color("Layer2"))
                    .rotationEffect(.degrees(-90), anchor: .bottomTrailing)
                    .padding(.top, -72)
            }
            .padding(.top, 14)
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleView(fontSize: 60)
    }
}
