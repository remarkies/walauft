//
//  ContentView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedRegion: RegionModel?
    
    var body: some View {
        HomeView()
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
