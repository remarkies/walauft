//
//  EventInfoView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 11.12.20.
//

import SwiftUI

struct EventInfoView: View {
    var event: EventModel
    var body: some View {
        VStack (alignment: .leading) {
            EventTextInfoView(title: "Event", text: Text("\(event.name)"))
            
            if event.tags.filter { tag in return tag.type == .act }.count > 0 {
                EventTagsInfoView(title: "Acts", tags: event.tags, tagType: .act)
            }
            
            if event.tags.filter { tag in return tag.type == .style }.count > 0 {
                EventTagsInfoView(title: "Genres", tags: event.tags, tagType: .style)
            }
            
            if event.minage != nil && event.minage! > 0 {
                EventTextInfoView(title: "Alter", text: Text("\(event.minage!)+"))
            }
            
            if event.price != nil && event.price! > 0 {
                EventTextInfoView(title: "Price", text: Text("CHF \(event.price!, specifier: "%.2f")"))
            }
            
            if event.description.count > 0 {
                EventTextInfoView(title: "Beschriebig", text: Text("\(event.description)"))
            }
        }
    }
}

struct EventInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
