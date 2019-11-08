import Foundation

public struct Color: Equatable, Codable, CustomStringConvertible {

    public let r: Double

    public let g: Double

    public let b: Double

    public let name: String?

    public let mode: Mode

    public init(_ r: Double, _ g: Double, _ b: Double, name: String? = nil, mode: Mode = Color.defaultMode) {
        self.r = r
        self.g = g
        self.b = b
        self.name = name
        self.mode = mode
    }

    public init(_ hex: String, name: String? = nil, mode: Mode = Color.defaultMode) {
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            self.r = Double((color & 0xFF0000) >> 16) / mode.max
            self.g = Double((color & 0x00FF00) >> 8) / mode.max
            self.b = Double((color & 0x0000FF) >> 0) / mode.max
            self.name = name ?? hex
            self.mode = mode
        } else {
            self.r = 0
            self.g = 0
            self.b = 0
            self.name = nil
            self.mode = mode
        }
    }

    public enum Mode: String, Codable {
        case range1
        case range255
    }

    public static var defaultMode: Mode = .range255

    // MARK: - CustomStringConvertible

    public var description: String {
        return "\(name ?? "") (\(r),\(g),\(b)) by \(mode)"
    }

}

extension Color.Mode {

    fileprivate var min: Double {
        switch self {
        case .range1: return 0
        case .range255: return 0
        }
    }

    fileprivate var max: Double {
        switch self {
        case .range1: return 1
        case .range255: return 255
        }
    }

}
