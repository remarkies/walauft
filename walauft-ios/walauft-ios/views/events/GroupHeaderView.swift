//
//  GroupHeaderView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 12.12.20.
//

import SwiftUI

struct GroupHeaderView: View {
    var text: String
    var body: some View {
        VStack {
            HStack {
                Text("\(text)")
                    .bold()
                    .font(.custom("Manrope-Bold", size: 20))
                    .foregroundColor(Color("Layer2"))
                    .padding(.leading)
                    .padding(.top)
                Spacer()
            }
            Divider()
                .frame(height: 2)
                .background(Color("Layer1"))
        }
    }
}

struct GroupHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GroupHeaderView(text: "13. Dezember")
    }
}
