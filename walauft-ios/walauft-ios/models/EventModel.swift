//
//  Event.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

struct EventModel: Codable {
    let id: String
    let name: String
    let acts: String
    let start: String
    let end: String?
    let location: LocationModel?
    let musicstyles: String
    let minage: String
    let minagef: String
    let price: String
    let text: String
    let comments: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        acts = try container.decode(String.self, forKey: .acts)
        start = try container.decode(String.self, forKey: .start)
        end = try container.decode(String?.self, forKey: .end)
        location = try container.decode(LocationModel?.self, forKey: .location)
        musicstyles = try container.decode(String.self, forKey: .musicstyles)
        minage = try container.decode(String.self, forKey: .minage)
        minagef = try container.decode(String.self, forKey: .minagef)
        price = try container.decode(String.self, forKey: .price)
        text = try container.decode(String.self, forKey: .text)
        comments = try container.decode(String.self, forKey: .comments)
    }
}
