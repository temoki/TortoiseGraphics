import Foundation
import CoreGraphics

public extension Tortoise {

    // MARK: - Tortoise's State

    public var position: (x: Double, y: Double) {
        return (x: Double(state.position.x), y: Double(state.position.y))
    }

    public var pos: (x: Double, y: Double) {
        return position
    }

    public func towards(_ x: Double, y: Double) -> Double {
        let tan = (y - Double(state.position.y)) / (x - Double(state.position.x))
        return 90 - (atan(tan) * 180 / .pi)
    }

    public var xcor: Double {
        return Double(state.position.x)
    }

    public var ycor: Double {
        return Double(state.position.y)
    }

    public var heading: Double {
        return Double(state.heading)
    }

    public func distance(_ x: Double, y: Double) -> Double {
        let distanceX = x - Double(state.position.x)
        let distanceY = y - Double(state.position.y)
        return sqrt(pow(distanceX, 2) + pow(distanceY, 2))
    }

    public func random(_ max: Double) -> Double {
        let upperBound = UInt32(Swift.min(Swift.max(Int64(max), 0), Int64(UInt32.max)))
        return Double(arc4random_uniform(upperBound))
    }

}
