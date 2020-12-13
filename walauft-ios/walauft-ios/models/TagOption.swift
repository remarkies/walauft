//
//  TagOption.swift
//  walauft-ios
//
//  Created by Luka Kramer on 12.12.20.
//

import Foundation

enum TagOption : String, Codable {
    case style = "style"
    case act = "act"
    case location = "location"
    case unknown
}
extension TagOption {

    private enum CodingKeys: String, CodingKey {
        case style
        case act
        case location
        case unknown
    }

    enum TagOptionCodingError: Error {
        case decoding(String)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(String.self, forKey: .style) {
            self = TagOption(rawValue: value) ?? .unknown
            return
        }
        if let value = try? values.decode(String.self, forKey: .act) {
            self = TagOption(rawValue: value) ?? .unknown
            return
        }
        if let value = try? values.decode(String.self, forKey: .location) {
            self = TagOption(rawValue: value) ?? .unknown
            return
        }
        throw TagOptionCodingError.decoding("Whoops! \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
            case .style:
                try container.encode(self.rawValue, forKey: .style)
            case .act:
                try container.encode(self.rawValue, forKey: .act)
            case.location:
                try container.encode(self.rawValue, forKey: .location)
            case .unknown:
                try container.encode(self.rawValue, forKey: .unknown)
        }
    }
}
