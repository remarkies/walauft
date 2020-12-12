//
//  ApiTagModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Combine
import SwiftUI

class ApiTagModel: Codable, Equatable, Hashable {
    let id: UUID
    let date: String?
    let type: String
    let text: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        date = try? container.decode(String.self, forKey: .date)
        type = try container.decode(String.self, forKey: .type)
        text = try container.decode(String.self, forKey: .text)
    }
    
    enum CodingKeys: CodingKey {
        case date, type, text, id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(type)
        hasher.combine(text)
    }
    
    static func ==(lhs: ApiTagModel, rhs: ApiTagModel) -> Bool {
        return lhs.type == rhs.type && lhs.text == rhs.text
    }
}
