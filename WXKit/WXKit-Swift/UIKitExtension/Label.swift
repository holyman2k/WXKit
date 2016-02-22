//
//  Label.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

import UIKit

extension String {

    func trim() -> String {
        let trimCharSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        return self.stringByTrimmingCharactersInSet(trimCharSet)
    }

    func height(font:UIFont, andWidth width:CGFloat) -> CGFloat {
        let attributes = [NSFontAttributeName: font]
        let size = CGSizeMake(width, FLT_MAX.f)
        return self.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).height
        
    }
}