//
//  Region.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import Foundation
import CoreLocation
import SwiftUI
class RegionModel: Hashable, Equatable, ObservableObject {
    @ObservedObject private var locationManager = LocationManager()
    var id: Int
    var name: String
    var position: CLLocation
    var distanceToUser: Double?
    init(id: Int, name: String, position: CLLocation) {
        self.id = id
        self.name = name
        self.position = position
    }
    
    static func ==(lhs: RegionModel, rhs: RegionModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
