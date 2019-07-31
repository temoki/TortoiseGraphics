import Foundation

public struct Shape: CustomStringConvertible {

    public let name: String

    public var isVisible: Bool = true

    public static var arrow: Shape {
        return Shape("arrow", path: .points([
            Vec2D( 0.00, 0.00),
            Vec2D( 0.50, -0.70),
            Vec2D( 0.00, -0.70),
            Vec2D( 0.00, -1.00),
            Vec2D( 0.00, -0.70),
            Vec2D(-0.50, -0.70)
            ]))
    }

    public static var tortoise: Shape {
        let side1: [Vec2D] = [
            Vec2D( 0.00, 0.75),
            Vec2D( 0.12, 0.63),
            Vec2D( 0.06, 0.39),
            Vec2D( 0.24, 0.18),
            Vec2D( 0.42, 0.30),
            Vec2D( 0.54, 0.24),
            Vec2D( 0.36, 0.06),
            Vec2D( 0.42, -0.18),
            Vec2D( 0.30, -0.42),
            Vec2D( 0.48, -0.60),
            Vec2D( 0.36, -0.75),
            Vec2D( 0.24, -0.54),
            Vec2D( 0.00, -0.66)
        ]
        let side2 = side1.map { Vec2D(-$0.x, $0.y) }.reversed()
        return Shape("tortoise", path: .points(side1 + side2))
    }

    public static var circle: Shape {
        return Shape("circle", path: .ellipse(origin: Vec2D(-0.5, -0.5), size: Vec2D(1, 1)))
    }

    public static var square: Shape {
        return Shape("square", path: .rect(origin: Vec2D(-0.5, -0.5), size: Vec2D(1, 1)))
    }

    public static var triangle: Shape {
        let y = cos(Double.pi / 6)
        return Shape("triangle", path: .points([Vec2D(0, 0), Vec2D(0.5, -y), Vec2D(-0.5, -y)]))
    }

    public static var classic: Shape {
        return Shape("classic", path: .points([Vec2D(0, 0), Vec2D(0.5, -1), Vec2D(0, -0.75), Vec2D(-0.5, -1)]))
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return name
    }

    // MARK: - Internal

    enum ShapePath {
        case points([Vec2D])
        case ellipse(origin: Vec2D, size: Vec2D)
        case rect(origin: Vec2D, size: Vec2D)
    }

    let path: ShapePath

    init(_ name: String, path: ShapePath) {
        self.name = name
        self.path = path
    }

}
