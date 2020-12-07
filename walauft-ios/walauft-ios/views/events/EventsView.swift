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
    @State var isListview : Bool = true
    @State private var selectedDate = 0
    @State var emptyEvents: [EventModel] = []
    
    static let weekDayDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE dd."
        return formatter
    }()
    
    
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
                HStack(alignment: .center){
                    Button(action: { isListview = true }, label: { Text("List").underline(isListview, color: Color("SubtleForeground"))})
                    Text(" / ")
                    Button(action: { isListview = false }, label: { Text("Map").underline(!isListview, color: Color("SubtleForeground"))})
                    
                }.padding(.horizontal, 24).foregroundColor(Color("SubtleForeground"))
                if (isListview) {
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
          
                if (!isListview){
                    if (self.filterService.filteredData.count > 0) {
                      
                        // MapsView(locations: everyLocationOnFirstDate)
                        let eventDates = self.filterService.filteredData.map{ obj in obj.date}
                        Picker(selection: $selectedDate, label: Text("")) {
                            ForEach(0 ..< min(eventDates.count, 4)) {
                                      Text("\(eventDates[$0], formatter: Self.weekDayDateFormat)").tag($0)
                                    
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                                //WheelPickerStyle
                       
                        MapViewRep(events: self.$filterService.filteredData[selectedDate].events, region: selectedRegion, evetsClickable: true).frame(width: .infinity, height: .infinity).ignoresSafeArea()
                    }
                    else {
                     
                        MapViewRep(events: $emptyEvents, region: selectedRegion, evetsClickable: true).frame(width: .infinity, height: .infinity)
                    }
                  
                 
                }
            }.padding(.top, 16)
        
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
