import CoreGraphics

extension Vec2D {

    init(point: CGPoint) {
        self.x = Double(point.x)
        self.y = Double(point.y)
    }

    init(size: CGSize) {
        self.x = Double(size.width)
        self.y = Double(size.height)
    }

    func toCGPoint() -> CGPoint {
        return CGPoint(x: x, y: y)
    }

    func toCGSize() -> CGSize {
        return CGSize(width: x, height: y)
    }

    func toCGPath() -> CGPath {
        return toCGPoint().toCGPath()
    }

    func moved(_ distance: Double, toward direction: Angle) -> Vec2D {
        let transform = CGAffineTransform(translationX: CGFloat(x), y: CGFloat(y))
            .rotated(by: CGFloat(-direction.radian))
        return Vec2D(point: CGPoint(x: 0, y: distance).applying(transform))
    }

}

extension Array where Element == Vec2D {

    func toCGPath() -> CGPath {
        return map { $0.toCGPoint() }.toCGPath()
    }

}
