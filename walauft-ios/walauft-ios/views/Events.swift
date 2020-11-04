//
//  Events.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct Events: View {
    @State var selectedRegion: Region
    
    @State var eventService = EventService()
    @State var regionDays: [RegionDay] = []
    
    var body: some View {
        VStack {
            Form {
                ForEach(self.regionDays, id: \._id) {
                    regionDay in
                    
                    RegionDayRow(regionDay: regionDay)
                }
            }
            .navigationBarTitle(self.selectedRegion.name, displayMode: .inline)
        }.onAppear {
            self.eventService.loadEventsAsync(region: self.selectedRegion) {
                (result) in
                
                if result != nil {
                    self.regionDays = result!
                }
                print("INFO: Loaded events for \(self.selectedRegion.name)")
            }
        }
    }
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events(selectedRegion: Region(id: 6, name: "Züri"))
    }
}
