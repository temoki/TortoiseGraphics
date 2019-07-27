import Foundation

public enum ColorPalette: String {

    case black
    case white
    case red
    case pink
    case purple
    case deepPurple
    case indigo
    case blue
    case lightBlue
    case cyan
    case teal
    case green
    case lightGreen
    case lime
    case yellow
    case amber
    case orange
    case deepOrange
    case brown
    case grey
    case blueGrey

    var rgb: RGB {
        // https://material.io/guidelines/style/color.html
        switch self {
        case .black: return RGB("000000", name: self.rawValue)
        case .white: return RGB("FFFFFF", name: self.rawValue)
        case .red: return RGB("F44336", name: self.rawValue)
        case .pink: return RGB("E91E63", name: self.rawValue)
        case .purple: return RGB("9C27B0", name: self.rawValue)
        case .deepPurple: return RGB("673AB7", name: self.rawValue)
        case .indigo: return RGB("3F51B5", name: self.rawValue)
        case .blue: return RGB("2196F3", name: self.rawValue)
        case .lightBlue: return RGB("03A9F4", name: self.rawValue)
        case .cyan: return RGB("00BCD4", name: self.rawValue)
        case .teal: return RGB("009688", name: self.rawValue)
        case .green: return RGB("4CAF50", name: self.rawValue)
        case .lightGreen: return RGB("8BC34A", name: self.rawValue)
        case .lime: return RGB("CDDC39", name: self.rawValue)
        case .yellow: return RGB("FFEB3B", name: self.rawValue)
        case .amber: return RGB("FFC107", name: self.rawValue)
        case .orange: return RGB("FF9800", name: self.rawValue)
        case .deepOrange: return RGB("FF5722", name: self.rawValue)
        case .brown: return RGB("795548", name: self.rawValue)
        case .grey: return RGB("9E9E9E", name: self.rawValue)
        case .blueGrey: return RGB("607D8B", name: self.rawValue)
        }
    }

}
