import Foundation

struct Angle {

    enum Unit: String {
        case degree
        case radian
    }

    let value: Double

    let unit: Unit

    init(_ value: Double, _ unit: Unit) {
        self.value = value
        self.unit = unit
    }

    var degree: Double {
        switch unit {
        case .degree: return value
        case .radian: return value * (180.0 / .pi)
        }
    }

    var radian: Double {
        switch unit {
        case .degree: return value * (.pi / 180.0)
        case .radian: return value
        }
    }

}

extension Angle: Codable {
}

extension Angle.Unit: Codable {
}
