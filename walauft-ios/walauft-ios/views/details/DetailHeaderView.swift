//
//  DetailHeaderView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI

struct DetailHeaderView: View {
    var title: Text
    var focusText: String
    var text: Text
    
    var body: some View {
        HStack (alignment: .center, spacing: 8) {
            title
                .bold()
                .foregroundColor(Color("Foreground"))
                .font(.system(size: 18))
                .textCase(.uppercase)
                .fixedSize(horizontal: true, vertical: false)
                .rotated()
            
            VStack (alignment: .leading) {
                Text("\(focusText)")
                    .bold()
                    .foregroundColor(Color("Foreground"))
                    .fixedSize(horizontal: true, vertical: false)
                text
                    .bold()
                    .foregroundColor(Color("Layer3"))
                    .fixedSize(horizontal: true, vertical: false)
            }
            
        }
        .font(.system(size: 16))
    }
}



struct DetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailHeaderView(title: Text("LOC"), focusText: "Neues Theater Spirgarten", text: Text("Zürich"))
        }
        .frame(width: 60, height: 500)
        .background(Color("Background"))
    }
}
