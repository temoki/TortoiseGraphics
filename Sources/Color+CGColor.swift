import Foundation
import CoreGraphics
#if os(iOS)
import UIKit
#endif

extension Color {

    var cgColor: CGColor {
        let scanner = Scanner(string: self.rawValue)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return CGColor.rgb(r, g, b)
        }
        return CGColor.rgb(0, 0, 0)
    }

}

extension CGColor {

    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> CGColor {
        #if os(iOS)
        return UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        #elseif os(macOS)
        return CGColor(red: red, green: green, blue: blue, alpha: 1)
        #endif
    }

    var rgb: (CGFloat, CGFloat, CGFloat) {
        var rgb: (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        guard let components = self.components else { return rgb }
        guard components.count > 0 else { return rgb }
        rgb.0 = components[0]
        guard components.count > 1 else { return rgb }
        rgb.1 = components[1]
        guard components.count > 2 else { return rgb }
        rgb.2 = components[2]
        return rgb
    }

}
