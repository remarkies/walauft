//
//  TagView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct TagView: View {
    
    @State var tag: TagModel
    var background: Color
    var clicked: () -> Void
    var unClicked: () -> Void
    
    var body: some View {
        VStack {
            Button(action: {
                self.tag.isSelected = !self.tag.isSelected
                
                // !!! its reversed, because changed right before
                if self.tag.isSelected {
                    self.clicked()
                } else {
                    self.unClicked()
                }
                
                
            }) {
                HStack {
                    switch self.tag.type {
                        case "act":
                            Image(systemName: "person.2").font(.system(size: 12, weight: .regular))
                        case "location":
                            Image(systemName: "music.house").font(.system(size: 12, weight: .regular))
                        case "date":
                            Image(systemName: "calendar").font(.system(size: 12, weight: .regular))
                        case "style":
                            Image(systemName: "music.note").font(.system(size: 12, weight: .regular))
                    default:
                        Image(systemName: "questionmark").font(.system(size: 12, weight: .regular))
                    }
                    
                    Text(self.tag.text)
                        .font(.system(size: 12))
                        .bold()
                        
                }
                .foregroundColor(tag.isSelected ? Color("Background") : Color("Foreground"))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
            
            }
            .background(tag.isSelected ? Color("Accent1") : self.background)
            .cornerRadius(3)
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}
