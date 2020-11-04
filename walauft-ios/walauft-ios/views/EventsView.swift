//
//  Events.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventsView: View {
    @State var selectedRegion: RegionModel
    
    @State var eventService = EventService()
    @State var regionDays: [RegionDayModel] = []
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(self.regionDays, id: \._id) {
                    regionDay in
                    
                    RegionDayRowView(regionDay: regionDay)
                }
            }
        }
        .background(Color("SnowStorm3"))
        .navigationBarTitle(self.selectedRegion.name, displayMode: .inline)
        .onAppear {
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
        EventsView(selectedRegion: RegionModel(id: 6, name: "Züri"))
    }
}
