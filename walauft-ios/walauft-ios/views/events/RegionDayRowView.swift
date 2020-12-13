//
//  RegionDayRow.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct RegionDayRowView: View {

    func getGermanDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "dd. MMMM"
        return formatter.string(from: date)
    }

    @State var regionDay: RegionDayModel

    var body: some View {
        if regionDay.events.count > 0 {
            ForEach(regionDay.events) {
                event in
                EventRowView(event: event)
            }
        }
    }
}

struct RegionDayRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}
    }
}
