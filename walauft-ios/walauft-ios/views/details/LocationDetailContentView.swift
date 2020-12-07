//
//  LocationDetailContentView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI
import MapKit

struct LocationDetailContentView: View {
    var event: EventModel
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                
                EventListInfoView(title: "Adresse", texts: [
                    "\(event.location!.street) \(event.location!.streetno)",
                    "\(event.location!.zipcode), \(event.location!.city)"
                ])       
                
                if ((event.location?.latitude) != nil){
                    VStack {
                        MapViewRep(events: [event], evetsClickable: false)
                            .cornerRadius(3)
                            .frame(idealWidth: 300, maxWidth: .infinity, minHeight: 300, idealHeight: 300, maxHeight: 300, alignment: .center)
                        CustomButton(icon: "map", text: "Open in Maps", accent: Color("Layer2"), action: {
                            MapService.openMapWithCoordinates(latitude: event.location!.latitude!, longitude: event.location!.longitude!, pinText: event.location!.name)
                        })
                     
                    }
                } else {
                    CustomButton(icon: "map", text: "Open in Maps", accent: Color("Layer2"), action: {
                        MapService.searchCoordinates(forAddress: "\(event.location!.street) \(event.location!.streetno), \(event.location!.zipcode), \(event.location!.city)") {
                            coordinate in
                            if coordinate != nil {
                                MapService.openMapWithCoordinates(latitude: coordinate!.latitude, longitude: coordinate!.longitude, pinText: event.location!.name)
                            }
                        }
                    })
                }
            }
            Spacer()
        }
        .padding(.leading, 10)
    }
}

struct LocationDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
