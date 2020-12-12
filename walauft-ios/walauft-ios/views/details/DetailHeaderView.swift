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
        VStack (alignment: .center, spacing: 0) {
            HStack {
                title
                    .bold()
                    .foregroundColor(Color("Foreground"))
                    
                    .textCase(.uppercase)
                    .fixedSize(horizontal: true, vertical: false)
                
                Spacer()
                
                Text("\(focusText)")
                    .bold()
                    .foregroundColor(Color("Foreground"))
                    .fixedSize(horizontal: true, vertical: false)
            }
            .font(.system(size: 20))
            HStack {
                text
                    .bold()
                    .foregroundColor(Color("Layer3"))
                    .fixedSize(horizontal: true, vertical: false)
                Spacer()
            }
            .font(.system(size: 16))
        }
        .padding(.bottom, 24)
    }
}



struct DetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailHeaderView(title: Text("Mittwuch"), focusText: "20:00", text: Text("11. Dezember"))
        }
        .background(Color("Background"))
    }
}
