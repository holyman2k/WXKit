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
        var cString:NSString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1) as NSString
        }
        if (cString.length != 6) {
            self.init()
            return
        }
        let redRange = NSMakeRange(0, 2)
        let redString = cString.substring(with: redRange)
        let greenRange = NSMakeRange(2, 2)
        let greenString = cString.substring(with: greenRange)
        let blueRange = NSMakeRange(4, 2)
        let blueString = cString.substring(with: blueRange)

        var redValue:CUnsignedInt = 0, greenValue:CUnsignedInt = 0, blueValue:CUnsignedInt = 0;
        Scanner(string: redString).scanHexInt32(&redValue)
        Scanner(string: greenString).scanHexInt32(&greenValue)
        Scanner(string: blueString).scanHexInt32(&blueValue)

        self.init(red: CGFloat(redValue) / 255.0, green: CGFloat(greenValue) / 255.0, blue: CGFloat(blueValue) / 255.0, alpha: CGFloat(alpha))
    }
}
