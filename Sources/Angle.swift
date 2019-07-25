import CoreGraphics

protocol Angle {

    var value: CGFloat { get set }

    var degree: CGFloat { get }

    var radian: CGFloat { get }

}

struct Degree: Angle {

    init(_ value: CGFloat) { self.value = value }

    var value: CGFloat

    var degree: CGFloat { return value }

    var radian: CGFloat { return value * (.pi / 180.0) }

}

struct Radian: Angle {

    init(_ value: CGFloat) { self.value = value }

    var value: CGFloat

    var degree: CGFloat { return value * (180.0 / .pi) }

    var radian: CGFloat { return value }

}
