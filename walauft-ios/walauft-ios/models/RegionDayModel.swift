//
//  RegionDay.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

struct RegionDayModel : Codable {
    let _id: String
    let date: Date
    let region: String
    var events: [EventModel]
    
    init(_id: String, date: Date, region: String, events: [EventModel]) {
        self._id = _id
        self.date = date
        self.region = region
        self.events = events
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        _id = try container.decode(String.self, forKey: ._id)
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter.yyyyMMdd
        
        if let date = formatter.date(from: dateString) {
          self.date = date
        } else {
            print(dateString)
            throw DecodingError.dataCorruptedError(forKey: .date,
                  in: container,
                  debugDescription: "Date string does not match format expected by formatter.")
        }
        
        region = try container.decode(String.self, forKey: .region)
        events = try container.decode([EventModel].self, forKey: .events)
    }
}

extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
