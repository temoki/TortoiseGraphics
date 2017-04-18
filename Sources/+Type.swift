//
//  Type.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

/// Tortoise
public typealias Tortoise = Procedure

/// Number type in the Tortoise's world
public typealias Number = CGFloat

/// Number output closure type
public typealias NumberOutput = (Properties) -> Number

/// Boolean output closure type
public typealias BoolOutput = (Properties) -> Bool

/// Line Cap Style
public typealias LineCap = CGLineCap

/// Drawing Handler
public typealias DrawingHandler = (CGImage) -> Void

/// Number
internal extension Number {

    /// to radian
    var radian: Number {
        return self * .pi / 180
    }

    /// to degree
    var degree: Number {
        return self * 180 / .pi
    }

    /// to integer
    var integer: Int {
        return Swift.max(Int(self), 0)
    }

}
