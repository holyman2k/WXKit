//
//  Numbers.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    var i:Int {
        return Int(self)
    }

    var d:Double {
        return Double(self)
    }
    var f:CGFloat {
        return CGFloat(self)
    }
}

extension Double {
    var i:Int {
        return Int(self)
    }

    var d:Double {
        return self
    }
    var f:CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat {
    var i:Int {
        return Int(self)
    }
    var d:Double {
        return Double(self)
    }
    var f:CGFloat {
        return self
    }
}

extension Int {
    var i:Int {
        return self
    }
    var d:Double {
        return Double(self)
    }

    var f:CGFloat {
        return CGFloat(self)
    }
}