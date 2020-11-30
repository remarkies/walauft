//
//  FilterInfoView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct FilterInfoView: View {
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(Color("Foreground"))
                .font(.system(size: 12))
                .textCase(.uppercase)
            Spacer()
        }
    }
}

struct FilterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilterInfoView(text: "Test")
    }
}
