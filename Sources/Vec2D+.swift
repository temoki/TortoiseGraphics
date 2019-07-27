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

}

extension Array where Element == Vec2D {

    func toCGPath() -> CGPath {
        return map { $0.toCGPoint() }.toCGPath()
    }

}
