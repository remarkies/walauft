//
//  Events.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventsView: View {
    @EnvironmentObject var filterService : FilterService
    @EnvironmentObject var selectedRegion: RegionModel

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
        ZStack (alignment: .topLeading) {
            Color("Layer1").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing: 0) {

                if (isListview) {
                    SearchBarView()

                    VStack (spacing: 0) {
                        RegionDayListView(days: self.$filterService.data)
                    }
                    .background(Color("Background"))
                    .ignoresSafeArea()
                }

                if (!isListview){
                    if (self.filterService.data.count > 0) {

                        // MapsView(locations: everyLocationOnFirstDate)
                        let eventDates = self.filterService.data.map{ obj in obj.date}
                        Picker(selection: $selectedDate, label: Text("")) {
                            ForEach(0 ..< min(eventDates.count, 4)) {
                                      Text("\(eventDates[$0], formatter: Self.weekDayDateFormat)").tag($0)

                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                                //WheelPickerStyle

                        MapViewRep(events: self.filterService.data[selectedDate].events, region: selectedRegion, eventsClickable: true).frame(width: .infinity, height: .infinity).ignoresSafeArea()
                    }
                    else {
                        let emptyEvents: [EventModel] = []
                        MapViewRep(events: emptyEvents, region: selectedRegion, eventsClickable: true).frame(width: .infinity, height: .infinity)
                    }


                }
            }.padding(.top, 16)

        }
        .onAppear() {
            self.filterService.filterTags = []
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(self.selectedRegion.name)
        .navigationBarItems(trailing:
            HStack(alignment: .center) {
                CustomIconButton(icon: "list.bullet", background: isListview ? Color("Layer2") : Color("Layer1"), foreground: Color("Foreground"), action: {
                    isListview = true
                })
                CustomIconButton(icon: "map", background: !isListview ? Color("Layer2") : Color("Layer1"), foreground: Color("Foreground"), action: {
                    isListview = false
                })
            }
        )

    }

}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
