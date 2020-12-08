//
//  EventRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventRowView: View {
    @EnvironmentObject var dataService : DataService
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
            NavigationLink(destination: DetailView(selectedEvent: event).environmentObject(selectedRegion).environmentObject(filterService)) {

                if self.event != nil {

                    VStack (alignment: .leading, spacing: 4) {
                        HStack (alignment: .top) {
                            EventHeaderItemView(text: Text("\(self.event!.date, formatter: Self.weekDayDateFormat)"))
                                .frame(width: 40)

                            EventHeaderItemView(text: Text(self.event!.location!.name))
                            Spacer()
                            EventHeaderItemView(text: Text(self.event!.start))
                        }
                        HStack {
                            if self.event!.minage != nil && self.event!.minage! > 0 {
                                HStack {
                                    Text("\(self.event!.minage!)+")
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
                            EventNameView(name: self.event!.name)
                            Spacer()

                           if self.event!.price != nil && self.event!.price! > 0{
                               HStack {
                                Spacer()
                                   Text("CHF \(self.event!.price!, specifier: "%.2f")")
                                        .font(.system(size: 12))
                                       .foregroundColor(Color("Accent1"))
                               }
                           }
                        }
                        HStack {
                            HStack {}
                            .frame(width: 48)
                            EventTagListView(tags: event!.tags)

                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    .foregroundColor(Color("Foreground"))
                    .cornerRadius(3)
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
