//
//  LocationModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

class LocationModel : Codable, Identifiable {
    let id = UUID()
    let name: String
    let street: String
    let streetNo: String
    let zipCode: String
    let city: String
    var longitude: Double?
    var latitude: Double?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        zipCode = try container.decode(String.self, forKey: .zipCode)
        street = try container.decode(String.self, forKey: .street)
        streetNo = try container.decode(String.self, forKey: .streetNo)
        
        let longitudeString : String? = try container.decode(String?.self, forKey: .longitude)
        let latitudeString : String? = try container.decode(String?.self, forKey: .latitude)
        if longitudeString != nil && latitudeString != nil &&
            Double(longitudeString!) != -1 && Double(latitudeString!) != -1 {
            longitude = Double(longitudeString!)
            latitude = Double(latitudeString!)
        } else {
            longitude = nil
            latitude = nil
        }
    }
}
