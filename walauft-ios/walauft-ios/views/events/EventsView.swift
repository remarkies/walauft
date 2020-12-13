//
//  Events.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventsView: View {
    @EnvironmentObject var dataViewModel : DataViewModel
    @EnvironmentObject var selectedRegion: RegionModel
    
    @State var searchText: String = ""
    @State var isListview : Bool = true
    @State var selectedDate = 0
    @State var emptyEvents: [EventModel] = []
    
    
    static let weekDayDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = " dd."
        return formatter
    }()
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color("Layer1").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing: 0) {
                SearchBarView()
                    .shadow(radius: 2)
                
                if (isListview) {
                    Group{
                        ZStack {
                            RegionDayListView(days: self.$dataViewModel.data)
                        }
                        .background(Color("Background"))
                        .ignoresSafeArea()
                    }
                    .transition(.move(edge: .leading))
                    
                }
                if (!isListview){
                    Group{
                        ZStack (alignment: .topLeading) {
                            MapViewRep(selectedDate: $selectedDate, eventsClickable: true).ignoresSafeArea()
                            
                            if (self.dataViewModel.data.count > 0) {
                                Picker(selection: $selectedDate, label: Text("")) {
                                    ForEach(0 ..< min(self.dataViewModel.datesAvailable.count, 3)) {
                                        Text("\(SwissGermanDateFormatter.getSwissWeekname(date: self.dataViewModel.datesAvailable[$0], short: true))\(self.dataViewModel.datesAvailable[$0], formatter: Self.weekDayDateFormat)")
                                            .tag($0)
                                            
                                    }
                                }
                                .font(.custom("Manrope-Bold", size: 12))
                                .textCase(.uppercase)
                                .cornerRadius(8)
                                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                            }
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
            }.padding(.top, 16)
        }
        .onAppear() {
            if self.dataViewModel.loadedRegion != nil &&
                self.dataViewModel.loadedRegion!.id != selectedRegion.id {
                self.dataViewModel.reset()
                self.dataViewModel.reloadEvents(region: selectedRegion)
            }
            
            
            if self.dataViewModel.data.count == 0 {
                self.dataViewModel.reloadEvents(region: selectedRegion)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(self.selectedRegion.name)
        .navigationBarItems(trailing:
            HStack(alignment: .center) {
                
                CustomIconButton(icon: "list.bullet", background: isListview ? Color("Layer2") : Color("Layer1"), foreground: Color("Foreground"), isSelected: isListview, action: {
                    withAnimation(.easeInOut(duration: 0.3)){
                        isListview = true
                    }
                }).animation(.easeIn)
                CustomIconButton(icon: "map", background: !isListview ? Color("Layer2") : Color("Layer1"), foreground: Color("Foreground"), isSelected: !isListview, action: {
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
