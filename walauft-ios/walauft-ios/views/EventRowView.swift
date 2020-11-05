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
        VStack (alignment: .leading) {
            Group {
                NavigationLink(destination: DetailView(selectedEvent: event)){
                    if self.event != nil {
                        HStack {
                            Image(systemName: "music.house").font(.system(size: 16, weight: .regular))
                            Text("\(event!.location!.name)")
                                .bold()
                            Spacer()
                            Text("\(event!.start)")
                                .bold()
                        }
                        .foregroundColor(Color("Foreground"))
                        .padding(16)
                    }
                }
                .background(Color("Layer2"))
                .shadow(radius: 2)
                
                HStack {
                    ForEach(TagService.getTagsForStyles(styles: self.event!.musicstyles), id: \.self) {
                        tag in
                        TagView(tag: tag)
                    }
                }
                .padding(.top, 8)
                .padding(.bottom , 16)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                
            }
        }
        .background(Color("Layer1"))
        .mask(RoundedRectangle(cornerRadius: 5.0))
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: nil)
    }
}
