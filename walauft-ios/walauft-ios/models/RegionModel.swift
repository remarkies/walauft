//
//  Region.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import Foundation

class RegionModel: Hashable, Equatable, ObservableObject {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func ==(lhs: RegionModel, rhs: RegionModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
