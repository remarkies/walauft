//
//  MapView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var longitude:Double
    @State var latitude:Double
    
    @State var defaultRegionSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    @State var region: MKCoordinateRegion? = nil
    
    var body: some View {
        VStack {
            
        }.onAppear {
            if var coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude) {
                self.region = MKCoordinateRegion(center: coordinates, span: self.defaultRegionSpan)
            }
            
            if self.region != nil {
                Map(coordinateRegion: region!)
                            .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinates: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389))
    }
}
