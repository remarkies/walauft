//
//  DateFormatter.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 12.12.20.
//

import Foundation

final class SwissGermanDateFormatter {
    static func getGermanDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "dd. MMMM"
        return formatter.string(from: date)
    }
   static func getSwissWeekname(date: Date, short: Bool)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        let weekDay = formatter.string(from: date)
        let enSwiShort = [("Mon","Men"), ("Tue", "Zis"), ("Wed", "Mit"), ("Thu", "Dun"), ("Fri", "Fri"), ("Sat", "Sam"), ("Sun", "Sun")]
        let enSwiLong = [("Mon","Mentig"), ("Tue", "Zistig"), ("Wed", "Mitttwoch"), ("Thu", "Dunnstig"), ("Fri", "Fritig"), ("Sat", "Samstig"), ("Sun", "Sunntig")]
        var found: [(String, String)]
        if short{   found = enSwiShort.filter{ (en,swi) in en == weekDay}}
        else {  found = enSwiLong.filter{ (en,swi) in en == weekDay}}
        return found[0].1
    }
}
