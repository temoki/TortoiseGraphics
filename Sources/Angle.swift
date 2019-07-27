import CoreGraphics

protocol Angle {

    var value: Double { get set }

    var degree: Double { get }

    var radian: Double { get }

}

struct Degree: Angle {

    init(_ value: Double) { self.value = value }

    var value: Double

    var degree: Double { return value }

    var radian: Double { return value * (.pi / 180.0) }

}

struct Radian: Angle {

    init(_ value: Double) { self.value = value }

    var value: Double

    var degree: Double { return value * (180.0 / .pi) }

    var radian: Double { return value }

}
