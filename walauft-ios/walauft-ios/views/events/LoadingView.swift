//
//  LoadingView.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 11.12.20.
//

import SwiftUI

struct LoadingView: View {
    @State var animatingVal: Double = 1.0
    let cricleHeight = CGFloat(10)
    let animationDuration = 0.5
    var body: some View {
        VStack{
            Text("WArt schnell")
                .bold()
                .foregroundColor(Color("Layer2"))
            HStack{
                Circle()
                    .fill(Color("Accent1"))
                    .frame(width: self.cricleHeight, height: self.cricleHeight)
                    .opacity(0.9)
                    .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true))
                    .offset(y: CGFloat( self.animatingVal))
                Circle()
                    .fill(Color("Accent2"))
                    .frame(width: self.cricleHeight, height: self.cricleHeight)
                    .opacity(0.9)
                    .animation(Animation.easeInOut(duration: animationDuration).delay(0.2).repeatForever(autoreverses: true))
                    .offset(y: CGFloat( self.animatingVal))
                Circle()
                    .fill(Color("Accent3"))
                    .frame(width: self.cricleHeight, height: self.cricleHeight)
                    .animation(Animation.easeInOut(duration: animationDuration).delay(0.3).repeatForever(autoreverses: true))
                    .offset(y: CGFloat( self.animatingVal))
            }
            .onAppear{self.animatingVal = 20}
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView().background(Color(.black))
    }
}
