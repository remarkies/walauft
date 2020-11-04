//
//  Location.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

struct Location : Codable {
    let id: String
    let name: String
    let city: String
    let zipcode: String
    let street: String
    let streetno: String
    let longitude: Double?
    let latitude: Double?
    let styles: String
    let url: URL?
    let description: String?
    let tel: String
    let openinghours: String
    let minimumage: String
    let email: String
    let stringTypes: String
    let image: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        zipcode = try container.decode(String.self, forKey: .zipcode)
        street = try container.decode(String.self, forKey: .street)
        streetno = try container.decode(String.self, forKey: .streetno)
        
        let longitudeString : String = try container.decode(String.self, forKey: .longitude)
        let latitudeString : String = try container.decode(String.self, forKey: .latitude)
        if longitudeString.count > 0 && latitudeString.count > 0{
            longitude = Double(longitudeString)
            latitude = Double(latitudeString)
        } else {
            longitude = nil
            latitude = nil
        }
        
        styles = try container.decode(String.self, forKey: .styles)
        let urlString = try container.decode(String.self, forKey: .url)
        url = URL(string: urlString)
        description = try container.decode(String?.self, forKey: .description)
        tel = try container.decode(String.self, forKey: .tel)
        openinghours = try container.decode(String.self, forKey: .openinghours)
        minimumage = try container.decode(String.self, forKey: .minimumage)
        email = try container.decode(String.self, forKey: .email)
        stringTypes = try container.decode(String.self, forKey: .stringTypes)
        image = try container.decode(String?.self, forKey: .image)
        
    }
}
