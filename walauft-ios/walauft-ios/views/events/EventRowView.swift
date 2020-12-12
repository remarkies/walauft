//
//  EventRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventRowView: View {

    @EnvironmentObject var dataService : DataService
    @EnvironmentObject var selectedRegion: RegionModel

    @State var event: EventModel


    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination: DetailView(selectedEvent: event).environmentObject(selectedRegion).environmentObject(dataService)) {

                VStack (alignment: .leading, spacing: 4) {
                    HStack (alignment: .top) {
                        EventHeaderItemView(text: Text("\(SwissGermanDateFormatter.getSwissWeekname(date: self.event.date, short: true))"))
                            .frame(width: 40)

                        EventHeaderItemView(text: Text(self.event.location.name))
                        Spacer()
                        EventHeaderItemView(text: Text(self.event.time))
                    }
                    HStack {
                        if self.event.minage != nil && self.event.minage! > 0 {
                            HStack {
                                Text("\(self.event.minage!)+")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("Accent1"))
                                Spacer()
                            }
                            .padding(.leading, 4)
                            .frame(width: 48)
                        } else {
                            HStack {}
                            .frame(width: 48)
                        }
                        EventNameView(name: self.event.name)
                        Spacer()

                       if self.event.price != nil && self.event.price! > 0{
                           HStack {
                            Spacer()
                               Text("CHF \(self.event.price!, specifier: "%.2f")")
                                    .font(.system(size: 12))
                                   .foregroundColor(Color("Accent1"))
                           }
                       }
                    }
                    HStack {
                        HStack {}
                        .frame(width: 48)
                        EventTagListView(tags: event.tags)

                    }
                }
                .padding(.top, 10)
                .foregroundColor(Color("Foreground"))
                .cornerRadius(3)
            }
        }
        .padding(.vertical, 4)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
