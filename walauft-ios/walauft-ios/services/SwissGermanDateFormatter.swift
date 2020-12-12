//
//  DateFormatter.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 12.12.20.
//

import Foundation

final class SwissGermanDateFormatter {
    static func getSwissDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "gsw_CH")
        formatter.dateFormat = "dd. MMMM"
        return formatter.string(from: date)
    }
    static func getLongSwissDay(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "gsw_CH")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
   static func getShortSwissDay(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        let weekDay = formatter.string(from: date)
        let enSwiShort = [("Mon","Men"), ("Tue", "Zis"), ("Wed", "Mit"), ("Thu", "Dun"), ("Fri", "Fri"), ("Sat", "Sam"), ("Sun", "Sun")]
        let found = enSwiShort.filter{(en,swi) in en == weekDay}
        return found[0].1
    }
}
