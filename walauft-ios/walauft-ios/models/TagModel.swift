//
//  TagModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Combine
import SwiftUI


class TagModel: Codable, Equatable, Identifiable {
    let id = UUID()
    let date: String?
    let type: TagOption
    let text: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try? container.decode(String.self, forKey: .date)
        let typeStr = try container.decode(String.self, forKey: .type)
        type = TagOption(rawValue: typeStr) ?? .unknown;
        text = try container.decode(String.self, forKey: .text)
    }
    
    enum CodingKeys: CodingKey {
        case date, type, text
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
    }
    
    static func ==(lhs: TagModel, rhs: TagModel) -> Bool {
        return lhs.type == rhs.type && lhs.text == rhs.text
    }
}
