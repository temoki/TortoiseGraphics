import Foundation

struct Angle: Equatable, Codable {

    static var currentUnit: Unit = .degree

    enum Unit: String, Codable {
        case degree
        case radian
    }

    init(_ value: Double, _ unit: Unit = Angle.currentUnit) {
        switch unit {
        case .degree:
            self.radian = value * (.pi / 180.0)
        case .radian:
            self.radian = value
        }
    }

    let radian: Double

    var degree: Double {
        return radian * (180.0 / .pi)
    }

    var value: Double {
        switch Angle.currentUnit {
        case .degree: return degree
        case .radian: return radian
        }
    }

}

func + (left: Angle, right: Angle) -> Angle {
    return Angle(left.value + right.value)
}

func - (left: Angle, right: Angle) -> Angle {
    return Angle(left.value - right.value)
}
