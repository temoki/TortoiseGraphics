import Foundation
import CoreGraphics

extension Color {

    var cgColor: CGColor {
        let scanner = Scanner(string: self.rawValue)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return CGColor(red: r, green: g, blue: b, alpha: 1)
        }
        return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }

}

extension CGColor {

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
