//
//  EventTagsInfoView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 06.12.20.
//

import SwiftUI

struct EventTagsInfoView: View {
    var title: String
    var tags: [TagModel]
    var tagType: TagOption
    
    @State private var totalHeight
              = CGFloat.zero
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("\(title)")
                .font(.custom("Manrope-Bold", size: 12))
                .foregroundColor(Color("Layer2"))
                .padding(.bottom, -2)
            WrappedTags(tags: tags.filter { tag in return tag.type == tagType })
                
        }
    }
}

struct EventTagsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EventTagsInfoView(title: "Genres", tags: [], tagType: .style)
    }
}
