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
            if self.purposedTags.filter { tag in return tag.isSelected == false }.count > 0 {
                VStack {
                    FilterInfoView(text: "Truck zum filtere")
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
                }
            }
            
            if self.filterTags.filter { tag in return tag.isSelected == true }.count > 0 {
                FilterInfoView(text: "Gsetzti Filter")
                ScrollView (.horizontal){
                    HStack {
                        ForEach(self.filterTags.filter { tag in return tag.isSelected == true }, id: \.text) {
                            tag in
                            TagView(tag: tag, clicked: {
                                if let index = self.filterTags.firstIndex(where: { $0.text == tag.text }) {
                                    filterTags.remove(at: index)
                                }
                            })
                        }
                    }
                    .padding(.bottom, 12)
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
