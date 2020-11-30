//
//  RegionListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI

struct RegionListView: View {
    
    @State var regions: [RegionModel] = [
        RegionModel(id: 2, name: "Lozärn"),
        RegionModel(id: 3, name: "Bärn"),
        RegionModel(id: 4, name: "Baasel"),
        RegionModel(id: 5, name: "St.Galle"),
        RegionModel(id: 6, name: "Züri")
    ]
    
    var body: some View {
        VStack  (alignment: .leading) {
            ForEach(self.regions, id: \.self) {
                region in
                NavigationLink(destination: EventsView(selectedRegion: region)
                                    .environmentObject(FilterService())){
                    RegionListItem(region: region)
                }
            }
        }
    }
}

struct RegionListView_Previews: PreviewProvider {
    static var previews: some View {
        RegionListView()
    }
}
