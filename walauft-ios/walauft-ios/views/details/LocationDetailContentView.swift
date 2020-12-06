//
//  LocationDetailContentView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI

struct LocationDetailContentView: View {
    var event: EventModel
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                EventTextInfoView(title: "Adresse", text: "\(event.location!.street) \(event.location!.streetno), \(event.location!.zipcode), \(event.location!.city)")                
                
                if ((event.location?.latitude) != nil){
                    MapsView(locations: [event.location!])
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .frame(idealWidth: 300, maxWidth: .infinity, minHeight: 300, idealHeight: 300, maxHeight: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
