//
//  Event.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

struct ApiEventModel: Codable, Hashable {
    let id: String
    let name: String
    let acts: String
    let date: Date
    let start: String
    let end: String?
    var location: ApiLocationModel?
    let musicstyles: String
    let minage: Int?
    let minagef: Int?
    let price: Double?
    let text: String
    let tags: [ApiTagModel]
    let comments: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        acts = try container.decode(String.self, forKey: .acts)
        
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter.yyyyMMdd2
        if let date = formatter.date(from: dateString) {
          self.date = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date,
                  in: container,
                  debugDescription: "Date string does not match format expected by formatter.")
        }
        
        start = try container.decode(String.self, forKey: .start)
        end = try container.decode(String?.self, forKey: .end)
        location = try container.decode(ApiLocationModel?.self, forKey: .location)
        musicstyles = try container.decode(String.self, forKey: .musicstyles)
        let minageString = try container.decode(String.self, forKey: .minage)
        let minagefString = try container.decode(String.self, forKey: .minage)
        
        if minageString.count > 0 {
            minage = Int(minageString)
        } else {
            minage = nil
        }
        if minagefString.count > 0 {
            minagef = Int(minagefString)
        } else {
            minagef = nil
        }
        
        let priceString = try container.decode(String.self, forKey: .price)
        if priceString.count > 0 {
            price = Double(priceString)
        } else {
            price = nil
        }
        
        text = try container.decode(String.self, forKey: .text)
        comments = try container.decode(String.self, forKey: .comments)
        tags = try container.decode([ApiTagModel].self, forKey: .tags)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: ApiEventModel, rhs: ApiEventModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DateFormatter {
  static let yyyyMMdd2: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

