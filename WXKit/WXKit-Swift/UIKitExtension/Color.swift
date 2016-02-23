//
//  Color.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex:String, andAlpha alpha:Double = 1) {
        var cString:NSString = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(1)
        }
        if (cString.length != 6) {
            self.init()
            return
        }
        let redRange = NSMakeRange(0, 2)
        let redString = cString.substringWithRange(redRange)
        let greenRange = NSMakeRange(2, 2)
        let greenString = cString.substringWithRange(greenRange)
        let blueRange = NSMakeRange(4, 2)
        let blueString = cString.substringWithRange(blueRange)

        var redValue:CUnsignedInt = 0, greenValue:CUnsignedInt = 0, blueValue:CUnsignedInt = 0;
        NSScanner(string: redString).scanHexInt(&redValue)
        NSScanner(string: greenString).scanHexInt(&greenValue)
        NSScanner(string: blueString).scanHexInt(&blueValue)

        self.init(red: CGFloat(redValue) / 255.0, green: CGFloat(greenValue) / 255.0, blue: CGFloat(blueValue) / 255.0, alpha: CGFloat(alpha))
    }
}