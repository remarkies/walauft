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
            VStack (spacing: 0) {

            }
        }
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
      
                MapViewRep(events: [selectedEvent!], evetsClickable: false).ignoresSafeArea()
            }

        }.navigationBarTitle(selectedEvent!.location!.name)
        

    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedEvent: nil)
    }
}
