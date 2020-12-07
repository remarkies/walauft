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
                EventTextInfoView(title: "Adresse", text: "\(event.location!.street) \(event.location!.streetno), \(event.location!.zipcode), \(event.location!.city)")                
                
                if ((event.location?.latitude) != nil){
                    VStack {
                        MapViewRep(events: [event], evetsClickable: false)
                            .cornerRadius(3)
                            .frame(idealWidth: 300, maxWidth: .infinity, minHeight: 300, idealHeight: 300, maxHeight: 300, alignment: .center)
                        Button ("Open in Maps", action: {
                            let latitude:CLLocationDegrees =  event.location!.latitude!
                            let longitude:CLLocationDegrees =  event.location!.longitude!

                            let regionDistance:CLLocationDistance = 10000
                            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                            let options = [
                                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                            ]
                            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                            let mapItem = MKMapItem(placemark: placemark)
                            mapItem.name = "\(event.location!.name)"
                            mapItem.openInMaps(launchOptions: options)
                        })
                    }
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
