//
//  TagView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import SwiftUI

struct TagView: View {
    
    var tag: TagModel
    
    var body: some View {
        HStack {
            switch self.tag.type {
                case "act":
                    Image(systemName: "person.2").font(.system(size: 10, weight: .regular))
                case "location":
                    Image(systemName: "music.house").font(.system(size: 10, weight: .regular))
                case "date":
                    Image(systemName: "calendar").font(.system(size: 10, weight: .regular))
                case "style":
                    Image(systemName: "music.note").font(.system(size: 10, weight: .regular))
            default:
                Image(systemName: "questionmark").font(.system(size: 16, weight: .regular))
            }
            
            Text(self.tag.text)
                .font(.system(size: 10))
                .bold()
                
        }
        .foregroundColor(Color("Foreground"))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color("Layer1"))
        .cornerRadius(3)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: TagModel(type: "location", text: "EXIL"))
    }
}
