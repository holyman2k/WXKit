//
//  Date.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

extension Date {
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarOptions: NSCalendar.Options {
            switch self {
            case .Next:
                return .matchNextTime
            case .Previous:
                return [.searchBackwards, .matchNextTime]
            }
        }
    }
    
    enum DayName : Int {
        case Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }

    func dateStringWithFormat(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    var dateStringLong:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, yyyy"
        return formatter.string(from: self)
    }

    var dateStringShort:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: self)
    }

    var dateWithoutTime:Date {

        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: self)
        return calendar.date(from: components)!
    }

    static func dateWithString(_ dateString:String, andFormat format:String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
    func get(direction: SearchDirection, _ day: DayName, considerToday consider: Bool = false) -> Date {
        
        let nextWeekDayIndex = day.rawValue
        
        let today = Date()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date!
    }
    
    var firstWeekDay:Date {

        let firstWeekday = NSLocale.current.calendar.firstWeekday
        let day = DayName(rawValue: firstWeekday)
        return self.get(direction:.Previous, day!);
    }
}
