//
//  Home.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct Home: View {
    
    @State var regions: [Region] = [
        Region(id: 2, name: "Lozärn"),
        Region(id: 3, name: "Bärn"),
        Region(id: 4, name: "Baasel"),
        Region(id: 5, name: "St.Galle"),
        Region(id: 6, name: "Züri")
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section (header: Text("Regions")) {
                        List {
                            ForEach(self.regions, id: \.self) {
                                region in
                                NavigationLink(destination: Events(selectedRegion: region)){
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
        Home()
    }
}
