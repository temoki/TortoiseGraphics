import Foundation

public struct Shape: CustomStringConvertible {

    public let name: String

    public var isVisible: Bool = true

    public static var arrow: Shape {
        return Shape("arrow", path: Path.arrowPath())
    }

    public static var tortoise: Shape {
        return Shape("tortoise", path: Path.tortoisePath())
    }

    public static var circle: Shape {
        return Shape("circle", path: Path.circlePath())
    }

    public static var square: Shape {
        return Shape("square", path: Path.squarePath())
    }

    public static var triangle: Shape {
        return Shape("triangle", path: Path.trianglePath())
    }

    public static var classic: Shape {
        return Shape("classic", path: Path.classicPath())
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return name
    }

    // MARK: - Internal

    enum Path {
        case points([Vec2D])
        case ellipse(origin: Vec2D, size: Vec2D)
        case rect(origin: Vec2D, size: Vec2D)
    }

    let path: Path

    init(_ name: String, path: Path) {
        self.name = name
        self.path = path
    }

}
