import CoreGraphics

extension Shape {

    func toCGPath() -> CGPath {
        return path.toCGPath()
    }

    func toScaledPath(by scale: CGFloat) -> CGPath {
        let scaledPath = CGMutablePath()
        scaledPath.addPath(path.toCGPath(), transform: CGAffineTransform(scaleX: scale, y: scale))
        return scaledPath
    }

}

extension Shape.ShapePath {

    func toCGPath() -> CGPath {
        switch self {
        case .points(let points):
            return points.toCGPath()
        case .ellipse(let origin, let size):
            return CGPath(ellipseIn: CGRect(origin: origin.toCGPoint(), size: size.toCGSize()), transform: nil)
        case .rect(let origin, let size):
            return CGPath(rect: CGRect(origin: origin.toCGPoint(), size: size.toCGSize()), transform: nil)
        }
    }

}
