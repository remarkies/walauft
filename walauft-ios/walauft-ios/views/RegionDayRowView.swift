//
//  RegionDayRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct RegionDayRowView: View {
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    @State var regionDay: RegionDayModel?
    
    var body: some View {
        if regionDay!.events.count > 0 {
            Section (header: Text("\(regionDay!.date, formatter: Self.taskDateFormat)")){
                ForEach(regionDay!.events, id: \.id) {
                    event in
                    EventRowView(event: event)
                }
            }
            
        }
    }
}

struct RegionDayRow_Previews: PreviewProvider {
    static var previews: some View {
        RegionDayRowView(regionDay: nil)
    }
}
