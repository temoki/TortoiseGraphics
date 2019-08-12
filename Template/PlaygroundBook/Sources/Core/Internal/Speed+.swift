import Foundation

extension Speed {

    var isNoAnimation: Bool {
        return velocity == 0
    }

    func movementDuration(distance: Double) -> CFTimeInterval {
        guard velocity != 0 else { return 0 }
        return CFTimeInterval(Double(distance) / (Double(velocity) * 100.0))
    }

    func animationDuration() -> CFTimeInterval {
        guard velocity != 0 else { return 0 }
        return CFTimeInterval(1.0 / Double(velocity))
    }

    private var velocity: UInt8 {
        switch self {
        case .fastest: return 0
        case .fast: return 8
        case .normal: return 6
        case .slow: return 4
        case .slowest: return 2
        }
    }

}
