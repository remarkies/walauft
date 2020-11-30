//
//  FilterView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var purposedTags: [TagModel]
    @State var selectedTags: [TagModel] = []
    
    var body: some View {
        ScrollView (.horizontal){
            HStack {
                ForEach(self.purposedTags, id: \.text) {
                    tag in
                    TagView(tag: tag)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{}
    }
}
