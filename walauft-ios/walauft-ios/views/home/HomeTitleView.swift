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
                .bold()
                .textCase(.uppercase)
                .font(.system(size: self.fontSize))
                .foregroundColor(Color("Layer1"))
                Spacer()
            }
            .padding(.leading, 10)
            Spacer()
            HStack {
                Spacer()
                Text("Walauft")
                    .bold()
                    .textCase(.uppercase)
                    .font(.system(size: self.fontSize))
                    .foregroundColor(Color("Layer2"))
                    .rotationEffect(.degrees(-90), anchor: .bottomTrailing)
                    .padding(.top, -72)
                    //.rotated()
            }
            .padding(.top, 10)
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleView(fontSize: 60)
    }
}
