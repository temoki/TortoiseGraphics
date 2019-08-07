import Foundation

struct TortoiseState {

    var position: Vec2D = Vec2D()

    var heading: Angle = Angle(0, .degree)

    var pen: Pen = Pen()

    var shape: Shape = .tortoise

    var speed: Speed = .normal

    var fillPath: [Vec2D]?

}
