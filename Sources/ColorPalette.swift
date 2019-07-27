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

    var color: Color {
        // https://material.io/guidelines/style/color.html
        switch self {
        case .black: return Color("000000", name: self.rawValue)
        case .white: return Color("FFFFFF", name: self.rawValue)
        case .red: return Color("F44336", name: self.rawValue)
        case .pink: return Color("E91E63", name: self.rawValue)
        case .purple: return Color("9C27B0", name: self.rawValue)
        case .deepPurple: return Color("673AB7", name: self.rawValue)
        case .indigo: return Color("3F51B5", name: self.rawValue)
        case .blue: return Color("2196F3", name: self.rawValue)
        case .lightBlue: return Color("03A9F4", name: self.rawValue)
        case .cyan: return Color("00BCD4", name: self.rawValue)
        case .teal: return Color("009688", name: self.rawValue)
        case .green: return Color("4CAF50", name: self.rawValue)
        case .lightGreen: return Color("8BC34A", name: self.rawValue)
        case .lime: return Color("CDDC39", name: self.rawValue)
        case .yellow: return Color("FFEB3B", name: self.rawValue)
        case .amber: return Color("FFC107", name: self.rawValue)
        case .orange: return Color("FF9800", name: self.rawValue)
        case .deepOrange: return Color("FF5722", name: self.rawValue)
        case .brown: return Color("795548", name: self.rawValue)
        case .grey: return Color("9E9E9E", name: self.rawValue)
        case .blueGrey: return Color("607D8B", name: self.rawValue)
        }
    }

}
