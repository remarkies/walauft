//
//  Detail.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @State var selectedEvent: EventModel?
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color("Background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView() {
                VStack (spacing: 16) {
                    EventDetailView(event: selectedEvent!)
                    LocationDetailView(event: selectedEvent!)
                    Spacer()
                }
            }
        }
        .navigationBarTitle(selectedEvent!.location!.name)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedEvent: nil)
    }
}
