//
//  DataModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 12.12.20.
//

import Foundation

class RegionDayModel : Identifiable {
    let id = UUID()
    let date: Date
    let region: RegionModel
    let events: [EventModel]
    
    init(date: Date, region: RegionModel, events: [EventModel]) {
        self.date = date
        self.region = region
        self.events = events
    }
}
