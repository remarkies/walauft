//
//  SearchBarView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText: String = ""
    var body: some View {
        CustomTextField(
                    placeholder: Text("Search for music styles...").foregroundColor(Color("SubtleForeground")),
                    text: $searchText
                )
            
        
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView()
        }
    }
}
