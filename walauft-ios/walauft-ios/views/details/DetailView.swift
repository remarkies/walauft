//
//  Detail.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI
import MapKit

struct DetailView: View {
 
    @State var selectedEvent: EventModel
    @State private var fitInScreen = false

    var body: some View {
        ZStack (alignment: .topLeading) {
            Color("Layer1").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

            VStack (alignment: .leading, spacing: 0) {
                Divider()
                    .frame(height: 2)
                    .background(Color("Layer3"))
                
                
                
                ScrollView {
                    VStack {
                        DetailHeaderView(title: Text("\(SwissGermanDateFormatter.getSwissWeekname(date: selectedEvent.date, short: false))"), focusText: selectedEvent.time, text: Text("\(SwissGermanDateFormatter.getGermanDate(date: selectedEvent.date))"))
                            .padding(.top, 24)
                        
                        EventDetailContentView(event: selectedEvent)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 48)
                }
                
            }
            .background(Color("Background"))
            .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle(selectedEvent.location.name)
    }
}


struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
 
