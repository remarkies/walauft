//
//  Events.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventsView: View {
    @EnvironmentObject var dataService : DataService
    @EnvironmentObject var selectedRegion: RegionModel
    
    @State var searchText: String = ""
    @State var isListview : Bool = true
    @State var selectedDate = 0
    @State var emptyEvents: [EventModel] = []
    
    
    static let weekDayDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE dd."
        return formatter
    }()
    init(){
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
    }
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color("Layer1").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing: 0) {
                SearchBarView()
                if (isListview) {
                    Group{
                        VStack (spacing: 0) {
                            RegionDayListView(days: self.$dataService.data)
                            
                        }
                        .background(Color("Background"))
                        .ignoresSafeArea()
                    }.transition(.move(edge: .leading))
                    
                }
                if (!isListview){
                    Group{
                        if (self.dataService.data.count > 0) {
                            let eventDates = self.dataService.data.map{ obj in obj.date}
                            Picker(selection: $selectedDate, label: Text("")) {
                                ForEach(0 ..< min(eventDates.count, 4)) {
                                    Text("\(eventDates[$0], formatter: Self.weekDayDateFormat)").tag($0)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        MapViewRep(selectedDate: $selectedDate, eventsClickable: true).ignoresSafeArea()
                    }.transition(.move(edge: .trailing))
                }
            }.padding(.top, 16)
        }
        .onAppear() {
            self.dataService.reloadEvents()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(self.selectedRegion.name)
        .navigationBarItems(trailing:
                                HStack(alignment: .center) {
                                    CustomIconButton(icon: "list.bullet", background: isListview ? Color("Layer2") : Color("Layer1"), foreground: Color("Foreground"), action: {
                                        withAnimation(.easeInOut(duration: 0.3)){
                                            isListview = true
                                            
                                        }
                                    }).animation(.easeIn)
                                    CustomIconButton(icon: "map", background: !isListview ? Color("Layer2") : Color("Layer1"), foreground: Color("Foreground"), action: {
                                        withAnimation(.easeInOut(duration: 0.3)){
                                            isListview = false
                                            
                                        }
                                    }).animation(.easeIn)
                                }
        )
        
    }
    
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}



