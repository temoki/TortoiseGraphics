//
//  Color+.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/27.
//

import Foundation
import CoreGraphics

extension Color {

    func toCGColor(alpha: CGFloat = 1) -> CGColor {
        #if os(iOS)
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(),
                       components: [CGFloat(r), CGFloat(g), CGFloat(b), 1])!
        // swiftlint:disable:previous force_unwrapping
        #elseif os(macOS)
        return CGColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
        #endif
    }

}
