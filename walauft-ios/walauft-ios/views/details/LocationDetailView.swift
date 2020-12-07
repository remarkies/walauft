//
//  LocationDetailView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI

struct LocationDetailView: View {
    @State private var labelHeight = CGFloat.zero
    
    var event: EventModel
    var body: some View {
        HStack (alignment: .top) {
            
            DetailHeaderView(title: Text("LOC"), focusText: event.location!.name, text: Text("\(event.location!.city)"))
                .rotated(Angle.degrees(90))
            
            Divider()
                .frame(width: 2)
                .background(Color("Layer3"))
            
            LocationDetailContentView(event: event)
        }
        .padding()
    }
}



struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}


