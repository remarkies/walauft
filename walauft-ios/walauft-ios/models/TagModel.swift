//
//  TagModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Combine
import SwiftUI

class TagModel: Codable, Equatable {
    
    var isSelected: Bool 
    let type: String
    let text: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(String.self, forKey: .type)
        text = try container.decode(String.self, forKey: .text)
        isSelected = false
    }
    
    enum CodingKeys: CodingKey {
        case type, text
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
    }
    
    static func ==(lhs: TagModel, rhs: TagModel) -> Bool {
        return lhs.type == rhs.type && lhs.text == rhs.text
    }
}
