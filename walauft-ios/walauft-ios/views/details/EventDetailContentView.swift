//
//  EventDetailContentView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI

struct EventDetailContentView: View {
    var event: EventModel
    var body: some View {
        VStack (alignment: .leading) {
            EventInfoView(event: event)
            
            EventListInfoView(title: "Adresse", texts: [
                "\(event.location.street) \(event.location.streetNo)",
                "\(event.location.zipCode), \(event.location.city)"
            ])
            
            if ((event.location.latitude) != nil) {
                VStack {
                    MapViewRep(event: event, eventsClickable: false)
                        .frame(height: 350)
                        .cornerRadius(3)
                    CustomButton(icon: "map", text: "Open in Maps", accent: Color("Layer2"), action: {
                        MapService.openMapWithCoordinates(latitude: event.location.latitude!, longitude: event.location.longitude!, pinText: event.location.name)
                    })
                 
                }
            } else {

                CustomButton(icon: "map", text: "Open in Maps", accent: Color("Layer2"), action: {
                    MapService.searchCoordinates(forAddress: "\(event.location.street) \(event.location.streetNo), \(event.location.zipCode), \(event.location.city)") {
                        coordinate in
                        if coordinate != nil {
                            MapService.openMapWithCoordinates(latitude: coordinate!.latitude, longitude: coordinate!.longitude, pinText: event.location.name)
                        }
                    }
                })
            }
        }
    }
}

struct EventDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
