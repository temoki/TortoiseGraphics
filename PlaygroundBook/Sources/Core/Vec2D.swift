import Foundation

public struct Vec2D: Equatable, Codable {

    public var x: Double
    public var y: Double

    public init(_ x: Double = 0, _ y: Double = 0) {
        self.x = x
        self.y = y
    }

}

public func + (lhs: Vec2D, rhs: Vec2D) -> Vec2D {
    return Vec2D(lhs.x + rhs.x, lhs.y + rhs.y)
}

public func - (lhs: Vec2D, rhs: Vec2D) -> Vec2D {
    return Vec2D(lhs.x - rhs.x, lhs.y - rhs.y)
}

public func * (lhs: Vec2D, rhs: Vec2D) -> Double {
    return lhs.x * rhs.x + lhs.y + rhs.y
}

public func * (lhs: Double, rhs: Vec2D) -> Vec2D {
    return Vec2D(lhs * rhs.x, lhs * rhs.y)
}

public func * (lhs: Vec2D, rhs: Double) -> Vec2D {
    return Vec2D(lhs.x * rhs, lhs.y * rhs)
}

public func abs(_ vec: Vec2D) -> Double {
    return (vec.x * vec.x + vec.y * vec.y).squareRoot()
}

extension Vec2D {

    public static let zero = Vec2D(0, 0)

    public func rotate(_ degree: Double) -> Vec2D {
        let radian = Double(Angle(degree, .degree).radian)
        return Vec2D(x * cos(radian) - y * sin(radian),
                     x * sin(radian) + y * cos(radian))
    }

}
