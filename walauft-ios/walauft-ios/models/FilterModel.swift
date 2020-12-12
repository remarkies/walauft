//
//  FilterModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 07.12.20.
//

import Foundation

struct FilterModel : Codable {
    var regionId: Int
    var tags: [ApiTagModel]
}
