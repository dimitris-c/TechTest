//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let iso8601: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
    
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let monthYearAndTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy 'at' HH:mm"
        
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

func ordinalDayWithMonthYear(from date: Date, showsTime: Bool) -> String {
    let formatter = showsTime ? DateFormatter.monthYearAndTime : DateFormatter.monthYear
    if showsTime {
        let day = Calendar.current.component(.day, from: date)
        let ordinalDay = NumberFormatter.ordinal.string(from: day as NSNumber) ?? "\(day)"
        let dateFormatted = formatter.string(from: date)
        return "\(ordinalDay) \(dateFormatted)"
    }
    let weekday = formatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date)]
    let day = Calendar.current.component(.day, from: date)
    let ordinalDay = NumberFormatter.ordinal.string(from: day as NSNumber) ?? "\(day)"
    let dateFormatted = formatter.string(from: date)
    return "\(weekday), \(ordinalDay) \(dateFormatted)"
}
