//
//  NoEventsFoundView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 11.12.20.
//

import SwiftUI

struct NoEventsFoundView: View {
    var body: some View {
        HStack {
            Image(systemName: "info").font(.system(size: 30, weight: .bold))
                .foregroundColor(Color("Layer2"))
            Text("Din Standort isch lame und bütet zurzit kei Events. Villicht liehts au am Berset..")
                .font(.system(size: 12))
                .bold()
                .foregroundColor(Color("Layer2"))
        }
        .padding()
        
    }
}

struct NoEventsFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NoEventsFoundView()
    }
}
