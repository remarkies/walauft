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
        formatter.dateFormat = "dd. MMMM"
        return formatter
    }()
    
    @State var regionDay: RegionDayModel?
    
    var body: some View {
        if regionDay!.events.count > 0 {
            
            VStack (alignment: .leading, spacing: 0){
                Text("\(regionDay!.date, formatter: Self.taskDateFormat)")
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("SubtleForeground"))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                
                Divider()
                    .frame(height: 2)
                    .background(Color("Layer2"))
                ForEach(regionDay!.events, id: \.id) {
                    event in
                    EventRowView(event: event)
                }
            }
            .padding(.top, 8)
        }
    }
}

struct RegionDayRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}
    }
}
