//
//  LocationMapView.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 23.11.20.
//

import SwiftUI
import MapKit


struct MapsView: View {
    init(locations: [LocationModel] = [] ) {
        self._locations = State(wrappedValue: locations)
        self._region = State(wrappedValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: locations[0].latitude!,
                longitude: locations[0].longitude!
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        ))
    }
    @State var locations: [LocationModel] = []
        
    @State private var region : MKCoordinateRegion

        var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations){ location in
                MapAnnotation(
                    coordinate: CLLocationCoordinate2D( latitude: location.latitude!,  longitude: location.longitude!),
                    anchorPoint: CGPoint(x: 0.5, y: 1)
                ) {
                    Button(action: { print(location.name) }, label: { TagView(tag: TagModel(type: "location", text: location.name)) })
                }
            }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 300)
            
        }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
    }
}
