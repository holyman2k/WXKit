//
//  String.swift
//  Youtube
//
//  Created by Charlie Wu on 22/03/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

extension String {

    static func isEmptyOrNil(string:String?) -> Bool {
        if let string = string {
            return string.trim().characters.count == 0
        } else {
            return true;
        }

    }
}
