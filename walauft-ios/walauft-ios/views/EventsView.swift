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
    @State var filterService = FilterService()
    @State var tagService = TagService()
    @State var data: [RegionDayModel] = [] {
        didSet{
            self.isWorking = true
            self.filterService.filterEventsWithTagsAsync(data: self.data, filterTags: self.selectedTags) {
                filteredData in
                
                if filteredData != nil {
                    self.filteredData = filteredData!
                } else {
                    self.filteredData = []
                }
                self.isWorking = false
            }
        }
    }
    @State var selectedTags: [TagModel] = []
    @State var proposedTags: [TagModel] = []
    @State var filteredData: [RegionDayModel] = []
    @State var isWorking: Bool = false
    @State var searchText: String = ""
    @State var isListview : Bool = true
    
    var body: some View {
        let bindingSearchText = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            
            tagService.loadTagsForSearchTextAsync(data: self.data, searchText: $0) {
                tags in
                if tags != nil {
                    self.proposedTags = tags!
                } else {
                    self.proposedTags = []
                }
                
            }
        })
        

            
           
        
        ZStack (alignment: .topLeading) {
            Color("Background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                HStack(alignment: .center){
                    Button(action: { isListview = true }, label: { Text("List").underline(isListview, color: Color("SubtleForeground"))})
                    Text(" / ")
                    Button(action: { isListview = false }, label: { Text("Map").underline(!isListview, color: Color("SubtleForeground"))})
                    
                }.padding(.horizontal, 24).foregroundColor(Color("SubtleForeground"))
                if (isListview) {
                    SearchBarView(searchText: bindingSearchText)
                    FilterView(purposedTags: $proposedTags)
                    ScrollView {
                        ForEach(self.filteredData, id: \._id) {
                            regionDay in
                            
                            RegionDayRowView(regionDay: regionDay)
                                
                        }
                    }
                }
                if (!isListview){
                    let everyLocationOnFirstDate = filteredData[0].events.map { event in event.location! }
                    MapsView(locations: everyLocationOnFirstDate)
                }
            }.padding(.top, 16)
           
        }
        .onAppear {
            self.eventService.loadEventsAsync(region: self.selectedRegion) {
                (result) in
                
                if result != nil {
                    self.data = result!
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
