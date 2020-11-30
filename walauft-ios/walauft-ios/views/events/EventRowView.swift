//
//  EventRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventRowView: View {
    
    static let weekDayDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter
    }()
    
    static let shortDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter
    }()
    
    @State var event: EventModel?

    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination: DetailView(selectedEvent: event)) {
                
                if self.event != nil {
                    VStack (alignment: .leading, spacing: 4) {
                        HStack (alignment: .lastTextBaseline) {
                            EventHeaderItemView(text: Text("\(self.event!.date, formatter: Self.weekDayDateFormat)"))
                                .frame(width: 40)
                            
                            EventHeaderItemView(text: Text(self.event!.location!.name))
                            Spacer()
                            EventHeaderItemView(text: Text(self.event!.start))
                        }
                        HStack {
                            HStack {}
                                .frame(width: 48)
                            EventNameView(name: self.event!.name)
                            Spacer()
                        }
                        HStack {
                            HStack {}
                                .frame(width: 48)
                            EventTagListView(tags: event!.tags)
                        }
                    }
                    .padding(.leading, 4)
                    .padding(.trailing, 10)
                    .foregroundColor(Color("Foreground"))
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
