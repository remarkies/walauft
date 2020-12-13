//
//  SearchBarView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var dataViewModel : DataViewModel
    @EnvironmentObject var selectedRegion : RegionModel
    @State var searchText: String = ""
    @State var proposedTags: [TagModel] = []
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            
            if self.searchText.count > 2 {
                ApiService.loadProposedTagsAsync(selectedRegion: selectedRegion, search: $0, completion: {
                    tags in
                    if tags != nil {
                        self.proposedTags = tags!
                    } else {
                        self.proposedTags = []
                    }
                })
            } else if self.searchText.count == 0 {
                self.proposedTags = []
            }
        })
        
        CustomTextField(
            placeholder: Text("Suech nach Genre, Clubs oder Künstler..."),
            text: binding
        )
        .padding(.bottom)
        
        VStack {
            if proposedTags.count > 0 {
                VStack {
                    FilterInfoView(text: "Truck s Chästli ah zum filtere")
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(proposedTags, id: \.id) {
                                tag in
                                TagView(tag: tag, background:  Color("Layer2"), clicked: {
                                    if self.dataViewModel.addFilterTag(tag: tag) {
                                        self.searchText = ""
                                        self.proposedTags = []
                                        self.hideKeyboard()
                                        self.dataViewModel.reloadEvents(region: selectedRegion)
                                    }
                                }, unClicked:{})
                            }
                        }
                        .padding(.bottom, 12)
                    }
                }
            }
            
            
            if self.dataViewModel.filterTags.count > 0 {
                FilterInfoView(text: "Gsetzti Chästli")
                ScrollView (.horizontal){
                    HStack {
                        ForEach(self.dataViewModel.filterTags) {
                            tag in
                            TagView(tag: tag, background:  Color("Layer2"), clicked: {}, unClicked: {
                                if self.dataViewModel.removeFilterTag(tag: tag) {
                                    self.dataViewModel.reloadEvents(region: selectedRegion)
                                }
                            })
                        }
                    }
                    .padding(.bottom, 12)
                }
                
            }
        }
        .padding(.horizontal)
        
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
