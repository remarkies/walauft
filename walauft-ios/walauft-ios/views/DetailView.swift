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
        VStack {
            Form {
                
                Section (header: Text("Event")){
                    Text("\(selectedEvent!.name)")
                }
                if selectedEvent!.acts.count > 0 {
                    Section (header: Text("Acts")){
                        Text("\(selectedEvent!.acts)")
                    }
                }
                
                if selectedEvent!.musicstyles.count > 0 {
                    Section (header: Text("Styles")){
                        Text("\(selectedEvent!.musicstyles)")
                    }
                }
                
                if selectedEvent!.text.count > 0 {
                    Section (header: Text("Description")){
                        Text("\(selectedEvent!.text)")
                    }
                }
                
            }
            if ((selectedEvent!.location?.latitude) != nil){
            MapsView(locations: [selectedEvent!.location!])
        }
        }.navigationBarTitle(selectedEvent!.location!.name).background(Color("Background"))
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedEvent: nil)
    }
}
