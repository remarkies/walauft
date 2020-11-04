//
//  Home.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct HomeView: View {
    
    @State var regions: [RegionModel] = [
        RegionModel(id: 2, name: "Lozärn"),
        RegionModel(id: 3, name: "Bärn"),
        RegionModel(id: 4, name: "Baasel"),
        RegionModel(id: 5, name: "St.Galle"),
        RegionModel(id: 6, name: "Züri")
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section (header: Text("Regions")) {
                        List {
                            ForEach(self.regions, id: \.self) {
                                region in
                                NavigationLink(destination: EventsView(selectedRegion: region)){
                                    HStack {
                                        Text("\(region.name)")
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("walauft.ch", displayMode: .inline)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
