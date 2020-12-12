//
//  TagModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 12.12.20.
//

import Foundation

enum TagOption : String {
    case style = "style"
    case act = "act"
    case location = "location"
    case unknown
}

class TagModel: Identifiable {
    let id = UUID()
    let type: TagOption
    let text: String
    
    init(type: TagOption, text: String) {
        self.type = type
        self.text = text
    }
}
