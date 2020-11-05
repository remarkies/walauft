//
//  GroupedTagsViews.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import SwiftUI

struct GroupedTagsView: View {
    
    @State var tags: [TagModel]?
    
    var body: some View {
        GeometryReader {
            geometry in
            self.generateContent(in: geometry)
        }
    }
        
    private func generateContent(in g: GeometryProxy) -> some View {
            var width = CGFloat.zero
            var height = CGFloat.zero

            return ZStack(alignment: .topLeading) {
                ForEach(self.tags!, id: \.self) { tag in
                    self.item(for: tag)
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if tag == self.tags!.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if tag == self.tags!.last! {
                                height = 0 // last item
                            }
                            return result
                        })
            }
        }
    }

    func item(for text: TagModel) -> some View {
        TagView(tag: text)
    }
}

struct GroupedTagsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedTagsView(tags: nil)
    }
}
