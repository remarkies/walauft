//
//  WrappedTags.swift
//  walauft-ios
//
//  Created by Luka Kramer on 08.12.20.
//

import SwiftUI

struct WrappedTags: View {
    var tags: [TagModel]

        @State private var totalHeight
              = CGFloat.zero       // << variant for ScrollView/List
        //    = CGFloat.infinity   // << variant for VStack

        var body: some View {
            VStack {
                GeometryReader { geometry in
                    self.generateContent(in: geometry)
                }
            }
            .frame(height: totalHeight)// << variant for ScrollView/List
            //.frame(maxHeight: totalHeight) // << variant for VStack
        }

        private func generateContent(in g: GeometryProxy) -> some View {
            var width = CGFloat.zero
            var height = CGFloat.zero

            return ZStack(alignment: .topLeading) {
                ForEach(self.tags, id: \.self) { tag in
                    self.item(for: tag)
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if tag == self.tags.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if tag == self.tags.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }
            .background(viewHeightReader($totalHeight))
            .padding(.top, -4)
            .padding(.leading, -4)
        }

        private func item(for tag: TagModel) -> some View {
            TagView(tag: tag,
                    background: Color("Layer1"),
                    clicked:{}, unClicked:{})
        }

        private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
            return GeometryReader { geometry -> Color in
                let rect = geometry.frame(in: .local)
                DispatchQueue.main.async {
                    binding.wrappedValue = rect.size.height
                }
                return .clear
            }
        }
}

struct WrappedTags_Previews: PreviewProvider {
    static var previews: some View {
        HStack{}
    }
}
