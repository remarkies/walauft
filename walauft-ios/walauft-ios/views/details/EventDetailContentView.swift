//
//  EventDetailContentView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI

struct EventDetailContentView: View {
    var event: EventModel
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                EventTextInfoView(title: "Event", text: event.name)
                
                if event.tags.filter { tag in return tag.type == "act" }.count > 0 {
                    EventTagsInfoView(title: "Acts", tags: event.tags, tagType: "act")
                }
                
                if event.tags.filter { tag in return tag.type == "style" }.count > 0 {
                    EventTagsInfoView(title: "Genres", tags: event.tags, tagType: "style")
                }
                
                if event.text.count > 0 {
                    EventTextInfoView(title: "Beschriebig", text: event.text)
                }
            }
            Spacer()
        }
        .padding(.leading, 10)
    }
}

struct EventDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
