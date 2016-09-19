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
        let trimCharSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: trimCharSet)
    }

    func height(_ font:UIFont, andWidth width:CGFloat) -> CGFloat {
        let attributes = [NSFontAttributeName: font]
        let size = CGSize(width: width, height: FLT_MAX.f)
        return self.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).height
    }
}
