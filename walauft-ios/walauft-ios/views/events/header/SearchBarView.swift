//
//  SearchBarView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct SearchBarView: View {
    @State var outputText: String = ""
    
    @Binding var searchText: String
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.outputText
        }, set: {
            self.outputText = $0
            // do whatever you want here
            self.searchText = $0
        })
        
        CustomTextField(
            placeholder: Text("Suech nach Genre, Clubs oder Künstler..."),
            text: binding
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group { }
    }
}
