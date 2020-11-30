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
                .padding(.horizontal)
                    .padding(.top)
                
                Spacer()
            }
                
            HStack {
                Spacer()
                Text("Walauft")
                    .bold()
                    .textCase(.uppercase)
                    .font(.system(size: self.fontSize))
                    .foregroundColor(Color("Layer2"))
                    .rotationEffect(.degrees(-90))
                    .padding(.horizontal, -100)
                    .padding(.top, 134)
            }
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleView(fontSize: 60)
    }
}
