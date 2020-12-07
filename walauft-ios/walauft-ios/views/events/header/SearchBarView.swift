//
//  SearchBarView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var filterService : FilterService
    
    @State var searchText: String = ""
    
    @State var proposedTags: [TagModel] = []
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            
            filterService.loadTagsForSearchTextAsync(data: self.filterService.data, searchText: $0) {
                tags in
                if tags != nil {
                    self.proposedTags = tags!
                } else {
                    self.proposedTags = []
                }
            }
        })
        
        CustomTextField(
            placeholder: Text("Suech nach Genre, Clubs oder Künstler..."),
            text: binding
        )
        .padding(.bottom)
        
        VStack {
            if proposedTags.filter { tag in return tag.isSelected == false }.count > 0 {
                VStack {
                    FilterInfoView(text: "Truck s chästli ah zum filtere")
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(proposedTags.filter { tag in return tag.isSelected == false }, id: \.text) {
                                tag in
                                TagView(tag: tag, background:  Color("Layer2"), clicked: {
                                    if !self.filterService.filterTags.contains(where: { $0 == tag }) {
                                        self.filterService.filterTags.append(tag)
                                        self.searchText = ""
                                    }
                                }, unClicked:{})
                            }
                        }
                        .padding(.bottom, 12)
                    }
                }
            }
            
            
            if self.filterService.filterTags.filter { tag in return tag.isSelected == true }.count > 0 {
                FilterInfoView(text: "Gsetzti Chästli")
                ScrollView (.horizontal){
                    HStack {
                        ForEach(self.filterService.filterTags.filter { tag in return tag.isSelected == true }, id: \.text) {
                            tag in
                            TagView(tag: tag, background:  Color("Layer2"), clicked: {}, unClicked: {
                                if let index = self.filterService.filterTags.firstIndex(where: { $0 == tag }) {
                                    self.filterService.filterTags.remove(at: index)
                                }
                            })
                        }
                    }
                    .padding(.bottom, 12)
                }
                
            }
        }
        .padding(.horizontal, 24)
        
        Divider()
            .frame(height: 2)
            .background(Color("Layer3"))
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
