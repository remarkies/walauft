//
//  Event.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

struct Event: Codable {
    let id: String
    let name: String
    let acts: String
    let date: String
    let dateAsTimestamp: Int
    let start: String
    let end: String?
    let city: String?
    let image: String?
    let flyerFront: String?
    let flyerBack: String?
    let eventPushImage: String
    let location: Location?
    let photographers: String?
    let isAttending: String?
    let competition: String?
    let canSaleTickets: Bool
    let musicstyles: String?
    let musicStylesIds: String?
    let minage: String
    let minagef: String
    let price: String
    let price_presale: String
    let price_earlybird: String
    let price_paymit: String
    let presale: String
    let text: String
    let comments: String
    let eventType: String
    let eventTypeId: String
    let movieurl: String
    let status: String
    let url: String
    let hasFacebookButton: Bool
    let fbLink: String?
}
