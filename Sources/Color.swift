//
//  Color.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

/// Color
struct Color {

    /// Red component
    let r: Number

    /// Green component
    let g: Number

    /// Blue component
    let b: Number

    /// Opacity component
    let opacity: Number

    /// Alpha computed from opacity
    var alpha: Number {
        return 1 - opacity
    }

    /// Components [R, G, B, Opacity]
    var components: [Number] {
        return [r, g, b, opacity]
    }

    /// CGColor
    let cgColor: CGColor

    /// Initializer
    /// - parameter r: Red component
    /// - parameter g: Green component
    /// - parameter b: Blue component
    /// - parameter opacity: Opacity component
    /// - parameter high: High value of each components
    init(r: Number, g: Number, b: Number, opacity: Number = 0, high: Number = 1) {
        self.r = min(max(r/high, 0), 1)
        self.g = min(max(g/high, 0), 1)
        self.b = min(max(b/high, 0), 1)
        self.opacity = min(max(opacity/high, 0), 1)

        let components = [self.r, self.g, self.b, (1 - self.opacity)]
        self.cgColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: components)!
        // swiftlint:disable:previous force_unwrapping
    }

    /// Initializer
    /// - parameter components: RGB and Opacity components
    /// - parameter high: High value of each component
    init(components: [Number], high: Number = 1) {
        var reversedComponents = Array(components.reversed())
        let r = reversedComponents.popLast() ?? 0
        let g = reversedComponents.popLast() ?? 0
        let b = reversedComponents.popLast() ?? 0
        let opacity = reversedComponents.popLast() ?? 0
        self.init(r: r, g: g, b: b, opacity: opacity, high: high)
    }

}
