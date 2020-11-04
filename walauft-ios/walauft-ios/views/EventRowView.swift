//
//  EventRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventRowView: View {
    
    @State var event: EventModel?
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            NavigationLink(destination: DetailView(selectedEvent: event)){
                if self.event != nil {
                    HStack {
                        Text("\(event!.location!.name)")
                        Spacer()
                        Text("\(event!.start)")
                    }
                }
            }
            HStack {
                ForEach(TagService.getTagsForStyles(styles: self.event!.musicstyles), id: \.self) {
                    tag in
                    TagView(tag: tag)
                }
                
            }
        }
        .padding(.vertical, 8)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: nil)
    }
}
