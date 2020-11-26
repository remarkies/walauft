//
//  EventRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct EventRowView: View {
    
    @State var event: EventModel?
    @EnvironmentObject var filterService : FilterService
    
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
    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination: DetailView(selectedEvent: event)) {
                
                if self.event != nil {
                    
                    HStack {
                        //Weekday
                        VStack (alignment: .center) {
                            
                            Text("\(self.event!.date, formatter: Self.weekDayDateFormat)")
                                .bold()
                                .textCase(.uppercase)
                                .font(.system(size: 16))
                                .foregroundColor(Color("SubtleForeground"))
                                .padding(.leading, 12)
                                .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        
                        Group {
                            VStack (alignment: .leading, spacing: 0) {
                                HStack {
                                    //Location part of event row
                                    VStack (alignment: .leading) {
                                            Text("\(event!.location!.name)")
                                                .bold()
                                                .textCase(.uppercase)
                                                .font(.system(size: 16))
                                            Text("\(event!.name)")
                                                .font(.system(size: 12))
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    // Time part of event row
                                    VStack (alignment: .leading) {
                                        Text("\(event!.start)")
                                            .bold()
                                            .font(.system(size: 16))
                                        
                                        Spacer()
                                    }
                                    
                                }
                                HStack {
                                    ScrollView (.horizontal){
                                        HStack {
                                            ForEach(self.event!.tags.filter { tag in return tag.type == "style" }, id: \.text) {
                                                tag in
                                                TagView(tag: tag, background:  Color("Layer1"), clicked: {
                                                    if !self.filterService.filterTags.contains(where: { $0 == tag }) {
                                                        self.filterService.filterTags.append(tag)
                                                    }
                                                }, unClicked: {
                                                    if let index = self.filterService.filterTags.firstIndex(where: { $0 == tag }) {
                                                        self.filterService.filterTags.remove(at: index)
                                                    }
                                                })
                                            }
                                        }
                                    }
                                    .padding(.bottom, 12)
                                }
                            }
                        }
                        .padding(.leading, 4)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.trailing, 10)
                    }
                    .foregroundColor(Color("Foreground"))
                    
                }
            }
        }
        //.background(Color("Layer1"))
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: nil)
    }
}
