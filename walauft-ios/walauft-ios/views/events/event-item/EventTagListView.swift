//
//  EventTagListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 26.11.20.
//

import SwiftUI

struct EventTagListView: View {
    
    @EnvironmentObject var filterService : FilterService
    @State var tags: [TagModel] = []
    
    var body: some View {
        ScrollView (.horizontal){
            HStack {
                ForEach(self.tags.filter { tag in return tag.type == "style" }, id: \.text) {
                    tag in
                    TagView(tag: tag, background:  Color("Layer1"), clicked: {
                        if !self.filterService.filterTags.contains(where: { $0 == tag }) {
                            self.filterService.filterTags.append(tag)
                        }
                    }, unClicked: {
                        if let index = self.filterService.filterTags.firstIndex(where: { $0 == tag }) {
                            self.filterService.filterTags.remove(at: index)
                        }
                    })
                }
            }.padding(.bottom, 12)
        }
        
    }
}

struct EventTagListView_Previews: PreviewProvider {
    static var previews: some View {
        EventTagListView()
    }
}
