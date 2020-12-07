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
            Color("Layer1").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Divider()
                    .frame(height: 2)
                    .background(Color("Layer3"))
                
                ScrollView() {
                    VStack (spacing: 16) {
                        EventDetailView(event: selectedEvent!)
                        LocationDetailView(event: selectedEvent!)
                    }
                    
                }
            }
            .background(Color("Background"))
            .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle(selectedEvent!.location!.name)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedEvent: nil)
    }
}
