//
//  EventDetailView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI


struct EventDetailView: View {
    
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
    
    static let eventDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd. MMM"
        return formatter
    }()
    
    
    var event: EventModel
    
    var body: some View {
        HStack (alignment: .top) {
            DetailHeaderView(title: Text("\(event.date, formatter: Self.weekDayDateFormat)"), focusText: event.start, text: Text("\(event.date, formatter: Self.eventDateFormat)"))
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
