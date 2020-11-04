//
//  EventRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventRow: View {
    
    @State var event: Event?
    
    var body: some View {
        NavigationLink(destination: Detail(selectedEvent: event)){
            if self.event != nil {
                HStack {
                    Text("\(event!.location!.name)")
                    Spacer()
                    Text("\(event!.start)")
                }
            }
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: nil)
    }
}
