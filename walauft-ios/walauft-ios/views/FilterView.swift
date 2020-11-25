//
//  FilterView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var purposedTags: [TagModel]
    @Binding var filterTags: [TagModel]
    
    var body: some View {
        VStack {
            ScrollView (.horizontal){
                HStack {
                    ForEach(self.purposedTags.filter { tag in return tag.isSelected == false }, id: \.text) {
                        tag in
                        TagView(tag: tag, clicked: {
                            if !self.filterTags.contains(where: { $0.text == tag.text }) {
                                self.filterTags.append(tag)
                            }
                        })
                    }
                }
                .padding(.bottom, 12)
            }
            ScrollView (.horizontal){
                HStack {
                    ForEach(self.filterTags.filter { tag in return tag.isSelected == true }, id: \.text) {
                        tag in
                        TagView(tag: tag, clicked: {
                            if let index = self.filterTags.firstIndex(where: { $0.text == tag.text }) {
                                filterTags.remove(at: index)
                            }
                            //self.filterTags.append(tag)
                        })
                    }
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
