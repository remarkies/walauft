//
//  Event.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

struct EventModel: Codable, Hashable {
    let id: String
    let name: String
    let acts: String
    let date: Date
    let start: String
    let end: String?
    var location: LocationModel?
    let musicstyles: String
    let minage: String
    let minagef: String
    let price: String
    let text: String
    let tags: [TagModel]
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
        location = try container.decode(LocationModel?.self, forKey: .location)
        musicstyles = try container.decode(String.self, forKey: .musicstyles)
        minage = try container.decode(String.self, forKey: .minage)
        minagef = try container.decode(String.self, forKey: .minagef)
        price = try container.decode(String.self, forKey: .price)
        text = try container.decode(String.self, forKey: .text)
        comments = try container.decode(String.self, forKey: .comments)
        tags = try container.decode([TagModel].self, forKey: .tags)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: EventModel, rhs: EventModel) -> Bool {
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

