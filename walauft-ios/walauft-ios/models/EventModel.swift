//
//  EventModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

class EventModel: Codable, Identifiable {
    let name: String
    let date: Date
    let time: String
    var location: LocationModel
    let minage: Int?
    let price: Double?
    let description: String
    let tags: [TagModel]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter.yyyyMMdd2
        if let date = formatter.date(from: dateString) {
          self.date = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date,
                  in: container,
                  debugDescription: "Date string does not match format expected by formatter.")
        }
        
        time = try container.decode(String.self, forKey: .time)
        location = try container.decode(LocationModel.self, forKey: .location)
        let minageString = try container.decode(String.self, forKey: .minage)
        
        if minageString.count > 0 {
            minage = Int(minageString)
        } else {
            minage = nil
        }
        
        let priceString = try container.decode(String.self, forKey: .price)
        if priceString.count > 0 {
            price = Double(priceString)
        } else {
            price = nil
        }
        
        description = try container.decode(String.self, forKey: .description)
        tags = try container.decode([TagModel].self, forKey: .tags)
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

