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
    @EnvironmentObject var filterService : FilterService
    @State var tagService = TagService()
    @State var proposedTags: [TagModel] = []
    @State var isWorking: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        let bindingSearchText = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            tagService.loadTagsForSearchTextAsync(data: self.filterService.data, searchText: $0) {
                tags in
                if tags != nil {
                    self.proposedTags = tags!
                } else {
                    self.proposedTags = []
                }
                
            }
        })
        
        ZStack (alignment: .topLeading) {
            Color("Layer1").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing: 0) {
                Group {
                    SearchBarView(searchText: bindingSearchText)
                        .padding(.bottom)
                    FilterView(purposedTags: $proposedTags)
                    Divider()
                        .frame(height: 2)
                        .background(Color("Layer3"))
                }
                
                VStack (spacing: 0) {
                    RegionDayListView(days: self.$filterService.filteredData)
                }
                .background(Color("Background"))
                .ignoresSafeArea()
                
            }
            .padding(.top, 16)
        }
        .onAppear {
            self.eventService.loadEventsAsync(region: self.selectedRegion) {
                (result) in
                
                if result != nil {
                    self.filterService.data = result!
                }
                print("INFO: Loaded events for \(self.selectedRegion.name)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(self.selectedRegion.name)
    }
    
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(selectedRegion: RegionModel(id: 6, name: "Züri"))
    }
}
