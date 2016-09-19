//
//  Date.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

extension Date {

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
}
