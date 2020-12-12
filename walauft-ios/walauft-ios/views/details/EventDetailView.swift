//
//  EventDetailView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI


struct EventDetailView: View {
    @EnvironmentObject var dataService : DataService

    static let shortDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"de")
        formatter.dateFormat = "dd.MM"
        return formatter
    }()
    
    static let eventDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"de")
        formatter.dateFormat = "dd. MMM"
        return formatter
    }()
    
    
    var event: EventModel
    
    var body: some View {
        HStack (alignment: .top) {
            DetailHeaderView(title: Text("\(dataService.getSwissWeekname(date: event.date))"), focusText: event.start, text: Text("\(event.date, formatter: Self.eventDateFormat)"))
                .rotated(Angle.degrees(90))
        
            Divider()
                .frame(width: 2)
                .background(Color("Layer3"))
            EventDetailContentView(event: event)
        }
        .padding()
        
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
