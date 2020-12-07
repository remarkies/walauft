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
    var tagType: String
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(title)")
                .bold()
                .font(.system(size: 12))
                .foregroundColor(Color("Foreground"))
            ScrollView (.horizontal){
                HStack {
                    ForEach(tags.filter { tag in return tag.type == tagType }, id: \.text) {
                        tag in
                        TagView(tag: tag,
                                background: Color("Layer1"),
                                clicked:{}, unClicked:{})
                    }
                }
                .padding(.bottom, 12)
            }
        }
    }
}

struct EventTagsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EventTagsInfoView(title: "Genres", tags: [], tagType: "act")
    }
}
