import Foundation

public struct Shape: Equatable, Codable, CustomStringConvertible {

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

    enum Path: Equatable {
        case points([Vec2D])
        case ellipse(Rect)
        case rect(Rect)
    }

    struct Rect: Equatable, Codable {
        var origin: Vec2D
        var size: Vec2D
    }

    let path: Path

    init(_ name: String, path: Path) {
        self.name = name
        self.path = path
    }

}

extension Shape.Path: Codable {

    private enum CodingKeys: String, CodingKey, CaseIterable {
        case points
        case ellipse
        case rect
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try container.decodeIfPresent([Vec2D].self, forKey: .points) {
            self = .points(value)
        } else if let value = try container.decodeIfPresent(Shape.Rect.self, forKey: .ellipse) {
            self = .ellipse(value)
        } else if let value = try container.decodeIfPresent(Shape.Rect.self, forKey: .rect) {
            self = .rect(value)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: CodingKeys.allCases,
                                                    debugDescription: "Does not match any CodingKey."))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .points(let value):
            try container.encode(value, forKey: .points)
        case .ellipse(let value):
            try container.encode(value, forKey: .ellipse)
        case .rect(let value):
            try container.encode(value, forKey: .rect)
        }
    }

}
