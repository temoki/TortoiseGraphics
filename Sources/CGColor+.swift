//
//  CGColor+.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/27.
//

import Foundation
import CoreGraphics

extension CGColor {

    static var clear: CGColor {
        return fromRGB(0, 0, 0, 0)
    }

    static func fromRGB(_ rgb: RGB, _ alpha: CGFloat = 1) -> CGColor {
        return fromRGB(CGFloat(rgb.r), CGFloat(rgb.g), CGFloat(rgb.b), alpha)
    }

    static func fromRGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat = 1) -> CGColor {
        #if os(iOS)
        // swiftlint:disable:next force_unwrapping
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [r, g, b, alpha])!
        #elseif os(macOS)
        return CGColor(red: red, green: green, blue: blue, alpha: alpha)
        #endif
    }

}
