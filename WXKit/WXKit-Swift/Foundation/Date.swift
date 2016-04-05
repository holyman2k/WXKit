//
//  Date.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

extension NSDate {

    func dateStringWithFormat(format:String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }

    var dateStringLong:String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.stringFromDate(self)
    }

    var dateStringShort:String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.stringFromDate(self)
    }

    var dateWithoutTime:NSDate {

        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: self)
        return calendar.dateFromComponents(components)!
    }

    static func dateWithString(dateString:String, andFormat format:String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)
    }
}