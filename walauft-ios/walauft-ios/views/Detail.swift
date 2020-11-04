//
//  Detail.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI
import MapKit

struct Detail: View {
    
    @State var selectedEvent: Event?
    
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
                
                if selectedEvent!.musicstyles != nil {
                    Section (header: Text("Styles")){
                        Text("\(selectedEvent!.musicstyles!)")
                    }
                }
            }
            
        }.navigationBarTitle(selectedEvent!.location!.name)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(selectedEvent: nil)
    }
}
