import Foundation
import CoreGraphics

public extension Tortoise {

    // MARK: - Tortoise's State

    public var position: (x: Double, y: Double) {
        return (x: Double(state.position.x), y: Double(state.position.y))
    }

    public var pos: (x: Double, y: Double) {
        return position
    }

    // TODO: towards(x,y) - eturn the angle between the line from turtle position to position specified by (x,y), the vector or the other turtle.

    public var xcor: Double {
        return Double(state.position.x)
    }

    public var ycor: Double {
        return Double(state.position.y)
    }

    public var heading: Double {
        return Double(state.heading)
    }

    // TODO: distance(x,y) - Return the distance from the turtle to (x,y), the given vector, or the given other turtle, in turtle step units.

}
