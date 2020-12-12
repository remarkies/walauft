//
//  RegionListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI
import CoreLocation
struct RegionListView: View {
    @ObservedObject private var locationManager = LocationManager()
    @State var regions: [RegionModel] = [
        RegionModel(id: 2, name: "Lozärn", position: CLLocation(latitude: 47.050820893720214, longitude: 8.310552721471659)),
        RegionModel(id: 3, name: "Bärn", position: CLLocation(latitude: 46.949289477443486, longitude: 7.438811145453266)),
        RegionModel(id: 4, name: "Baasel", position: CLLocation(latitude: 47.54771206711716,  longitude: 7.589704920303042)),
        RegionModel(id: 5, name: "St.Galle", position: CLLocation(latitude: 47.42310068418336, longitude: 9.369406855281206)),
        RegionModel(id: 6, name: "Züri", position: CLLocation(latitude: 47.379935134221896,  longitude: 8.532979765316039))
    ]
    
   init() {
     locationManager.sortedRegions = regions
   }
    var body: some View {
       
        
        return VStack(alignment: .leading) {
            ForEach(locationManager.sortedRegions!, id: \.self) {
                region in
                NavigationLink(destination:
                                EventsView()
                                .environmentObject(DataService(selectedRegion: region))
                                .environmentObject(region))
                {
                    RegionListItem(region: region)
                }
            }
            
            Button (action:{
                regions.append( RegionModel(id: 6, name: "Züri", position: CLLocation(latitude: 47.379935134221896,  longitude: 8.532979765316039)))
             
                
            }){
                //Text("\(locationManager.location == nil ? "nil": locationManager.location )")
            }
            
        }
    }
}

struct RegionListView_Previews: PreviewProvider {
    static var previews: some View {
        RegionListView()
    }
}
