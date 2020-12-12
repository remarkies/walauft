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
    
    @State var regionDay: RegionDayModel?
    
    var body: some View {
        if regionDay!.events.count > 0 {
            
            VStack (alignment: .leading, spacing: 0){
                Text("\(getGermanDate(date: regionDay!.date))")
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("Layer3"))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                
                Divider()
                    .frame(height: 2)
                    .background(Color("Layer3"))
                    .padding(.bottom, 10)
                
                ForEach(regionDay!.events, id: \.tags) {
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
