import Foundation

struct TortoiseState: Equatable, Codable {

    var position: Vec2D = Vec2D()

    var heading: Angle = Angle(0, .degree)

    var pen: Pen = Pen()

    var shape: Shape = .tortoise

    var speed: Speed = .normal

    var strokePath: [Vec2D] = []

    var fillPath: [Vec2D]?

}
