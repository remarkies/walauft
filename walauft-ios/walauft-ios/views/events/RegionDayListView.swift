//
//  RegionDayListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI

struct RegionDayListView: View {
    
    @Binding var days: [RegionDayModel]
    
    var body: some View {
        ScrollView {
            ForEach(days, id: \.events) {
                day in
                RegionDayRowView(regionDay: day)
                    
            }
        }
    }
}

struct RegionDayListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}
    }
}
