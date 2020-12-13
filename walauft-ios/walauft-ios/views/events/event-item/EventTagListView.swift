//
//  EventTagListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct EventTagListView: View {
    
    @EnvironmentObject var selectedRegion : RegionModel
    @EnvironmentObject var dataViewModel : DataViewModel
    @State var tags: [TagModel] = []
    
    var body: some View {
        ScrollView (.horizontal){
            HStack {
                ForEach(self.tags.filter { tag in return tag.type == .style }) {
                    tag in
                    TagView(tag: tag, background:  Color("Layer1"), clicked: {
                        if !self.dataViewModel.filterTags.contains(where: { $0.type == tag.type && $0.text == tag.text }) {
                            self.dataViewModel.filterTags.append(tag)
                            self.dataViewModel.reloadEvents(region: selectedRegion)
                        }
                    }, unClicked: {
                        if let index = self.dataViewModel.filterTags.firstIndex(where: { $0.type == tag.type && $0.text == tag.text
                        }) {
                            self.dataViewModel.filterTags.remove(at: index)
                            self.dataViewModel.reloadEvents(region: selectedRegion)
                        }
                    })
                }
            }
            .padding(.bottom, 12)
            .padding(.top, 4)
            .padding(.leading, 4)
        }
        
    }
}

struct EventTagListView_Previews: PreviewProvider {
    static var previews: some View {
        EventTagListView()
    }
}
