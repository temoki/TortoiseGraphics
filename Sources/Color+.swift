import Foundation
import CoreGraphics

extension Color {

    // https://material.io/guidelines/style/color.html
    var hexString: String {
        switch self {
        case .black: return "000000"
        case .white: return "FFFFFF"
        case .red: return "F44336"
        case .pink: return "E91E63"
        case .purple: return "9C27B0"
        case .deepPurple: return "673AB7"
        case .indigo: return "3F51B5"
        case .blue: return "2196F3"
        case .lightBlue: return "03A9F4"
        case .cyan: return "00BCD4"
        case .teal: return "009688"
        case .green: return "4CAF50"
        case .lightGreen: return "8BC34A"
        case .lime: return "CDDC39"
        case .yellow: return "FFEB3B"
        case .amber: return "FFC107"
        case .orange: return "FF9800"
        case .deepOrange: return "FF5722"
        case .brown: return "795548"
        case .grey: return "9E9E9E"
        case .blueGrey: return "607D8B"
        case .hex(let hexString): return hexString
        }
    }

    var cgColor: CGColor {
        let scanner = Scanner(string: self.hexString)
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

    static var clear: CGColor {
        return rgb(1, 1, 1, 0)
    }

    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> CGColor {
        #if os(iOS)
        // swiftlint:disable:next force_unwrapping
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [red, green, blue, alpha])!
        #elseif os(macOS)
        return CGColor(red: red, green: green, blue: blue, alpha: alpha)
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
