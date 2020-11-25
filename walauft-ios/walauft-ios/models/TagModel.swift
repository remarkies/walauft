//
//  TagModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Combine
import SwiftUI

class TagModel : ObservableObject, Codable {
    let objectWillChange = ObservableObjectPublisher()
    
    var isSelected: Bool {
        willSet {
            objectWillChange.send()
        }
    }
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
}
