//
//  LocationModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 12.12.20.
//

import Foundation

class LocationModel : Identifiable {
    let id = UUID()
    let name: String
    let street: String
    let streetNo: String
    let zipCode: String
    let city: String
    let longitude: Double?
    let latitude: Double?
    
    init(name: String, street: String, streetNo: String, zipCode: String, city: String, longitude: Double?, latitude: Double?) {
        self.name = name
        self.street = street
        self.streetNo = streetNo
        self.zipCode = zipCode
        self.city = city
        self.longitude = longitude
        self.latitude = latitude
    }
}
