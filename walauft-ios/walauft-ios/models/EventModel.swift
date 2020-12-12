//
//  EventModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 12.12.20.
//

import Foundation

class EventModel : Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    let time: String
    let tags: [TagModel]
    let minage: Int?
    let price: Double?
    let description: String
    let location: LocationModel
    
    init(name: String, date: Date, time: String, tags: [TagModel], minage: Int?, price: Double?, description: String, location: LocationModel) {
        self.name = name
        self.date = date
        self.time = time
        self.tags = tags
        self.minage = minage
        self.price = price
        self.description = description
        self.location = location
    }
}
