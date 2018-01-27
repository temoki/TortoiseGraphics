import CoreGraphics

public struct Shape {

    var name: String

    public static var arrow: Shape {
        return Shape("arrow", points: [(0, 0), (0.5, -0.7), (0, -0.7), (0, -1), (0, -0.7), (-0.5, -0.7)])
    }

    public static var tortoise: Shape {
        let oneSide: [(CGFloat, CGFloat)] = [(0, 0.75), (0.12, 0.63), (0.06, 0.39), (0.24, 0.18), (0.42, 0.30),
                                             (0.54, 0.24), (0.36, 0.06), (0.42, -0.18), (0.3, -0.42),
                                             (0.48, -0.6), (0.36, -0.75), (0.24, -0.54), (0, -0.66)]
        return Shape("tortoise", points: (oneSide + oneSide.map({(-$0.0, $0.1)}).reversed()))
    }

    public static var circle: Shape {
        return Shape("circle", path: CGPath(ellipseIn: CGRect(x: -0.5, y: -0.5, width: 1, height: 1), transform: nil))
    }

    public static var square: Shape {
        return Shape("square", path: CGPath(rect: CGRect(x: -0.5, y: -0.5, width: 1, height: 1), transform: nil))
    }

    public static var triangle: Shape {
        let y = cos(CGFloat.pi / 6)
        return Shape("triangle", points: [(0, 0), (0.5, -y), (-0.5, -y)])
    }

    public static var classic: Shape {
        return Shape("classic", points: [(0, 0), (0.5, -1), (0, -0.75), (-0.5, -1)])
    }

    // MARK: - Internal

    var path: CGPath

    init(_ name: String, path: CGPath) {
        self.name = name
        self.path = path
    }

    init(_ name: String, points: [(CGFloat, CGFloat)]) {
        let path = CGMutablePath()
        path.addLines(between: points.map({ CGPoint(x: $0.0, y: $0.1) }))
        self.name = name
        self.path = path
    }

    func scaledPath(by scale: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.addPath(self.path, transform: CGAffineTransform(scaleX: scale, y: scale))
        return path
    }

}
