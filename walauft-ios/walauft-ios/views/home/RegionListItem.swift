//
//  RegionListItem.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI
import CoreLocation
struct RegionListItem: View {
    
    var region: RegionModel
    
    var body: some View {
        HStack {
            HStack {
                Text("\(region.name)")
                    .font(.custom("Manrope-Bold", size: 50))
                    .bold()
                    .textCase(.uppercase)
                    .foregroundColor(Color("Foreground"))
                
                Spacer()
            }
            
        }
        .padding(.horizontal)
        
    }
}

struct RegionListItem_Previews: PreviewProvider {
    static var previews: some View {
        RegionListItem(region: RegionModel(id: 1, name: "Zürich", position: CLLocation(latitude:47.38037361934695,longitude: 8.531073592850248)))
    }
}
