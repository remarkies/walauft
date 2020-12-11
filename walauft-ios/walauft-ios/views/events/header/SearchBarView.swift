//
//  SearchBarView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var dataService : DataService
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
                    FilterInfoView(text: "Truck s chästli ah zum filtere")
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(proposedTags, id: \.id) {
                                tag in
                                TagView(tag: tag, background:  Color("Layer2"), clicked: {
                                    if !self.dataService.isFilterTag(tag: tag) {
                                        
                                        self.dataService.filterTags.append(tag)
                                        self.searchText = ""
                                        self.proposedTags = []
                                        self.hideKeyboard()
                                    }
                                }, unClicked:{})
                            }
                        }
                        .padding(.bottom, 12)
                    }
                }
            }
            
            
            if self.dataService.filterTags.count > 0 {
                FilterInfoView(text: "Gsetzti Chästli")
                ScrollView (.horizontal){
                    HStack {
                        ForEach(self.dataService.filterTags, id: \.id) {
                            tag in
                            TagView(tag: tag, background:  Color("Layer2"), clicked: {}, unClicked: {
                                if let index = self.dataService.filterTags.firstIndex(where: { $0 == tag }) {
                                    self.dataService.filterTags.remove(at: index)
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
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
