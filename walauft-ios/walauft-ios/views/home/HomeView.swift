//
//  Home.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                HomeTitleView(fontSize: 60)
                Spacer()
                RegionListView()
            }
            .padding(.top)
            .padding(.bottom)
            .background(Color("Background"))
            .ignoresSafeArea()
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
