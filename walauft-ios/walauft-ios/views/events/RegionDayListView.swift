//
//  RegionDayListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI

struct RegionDayListView: View {
    @EnvironmentObject var dataService : DataService
    @Binding var days: [RegionDayModel]
    
    var body: some View {
        
        if dataService.loading {
            VStack {
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("Accent1")))
                        .padding(.top, 24)
                    
                    Spacer()
                }
                Spacer()
            }
            
        } else if days.count > 0 {
            ScrollView {
                ForEach(days, id: \.events) {
                day in
                    RegionDayRowView(regionDay: day)
                }
            }
        } else {
            VStack {
                HStack {
                    Spacer()
                    
                    NoEventsFoundView()
                        .padding()
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct RegionDayListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}
    }
}
