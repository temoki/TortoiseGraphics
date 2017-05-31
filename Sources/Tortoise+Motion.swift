import Foundation
import CoreGraphics

/// Tortoise motion
public extension Tortoise {

    // MARK: - Move and Draw

    public func forward(_ distance: Double) {
        add(command: CommandForward(distance: CGFloat(distance)))
    }

    public func fd(_ distance: Double) {
        forward(distance)
    }

    public func backward(_ distance: Double) {
        forward(-distance)
    }

    public func back(_ distance: Double) {
        backward(distance)
    }

    public func bk(_ distance: Double) {
        backward(distance)
    }

    public func right(_ angle: Double) {
        add(command: CommandRight(angle: CGFloat(angle)))
    }

    public func rt(_ angle: Double) {
        right(angle)
    }

    public func left(_ angle: Double) {
        add(command: CommandRight(angle: -CGFloat(angle)))
    }

    public func lt(_ angle: Double) {
        left(angle)
    }

    public func setPosition(_ x: Double, _ y: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: x, y: y)))
    }

    public func setPos(_ x: Double, _ y: Double) {
        setPosition(x, y)
    }

    public func goto(_ x: Double, _ y: Double) {
        setPosition(x, y)
    }

    public func setX(_ x: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: CGFloat(x), y: state.position.y)))
    }

    public func setY(_ y: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: state.position.x, y: CGFloat(y))))
    }

    public func setHeading(_ heading: Double) {
        add(command: CommandSetHeading(heading: CGFloat(heading)))
    }

    public func setH(_ heading: Double) {
        setHeading(heading)
    }

    public func home() {
        add(command: CommandHome())
    }

    public func dot(_ size: Double? = nil) {
        add(command: CommandDot(size: size.map { CGFloat($0) }))
    }

    // TODO: circle()

    public func `repeat`(_ times: Int, _ block: () -> Void) {
        for _ in 1...times {
            block()
        }
    }

    // MARK: - Tell tortoise's state

    public var position: (x: Double, y: Double) {
        return (x: Double(state.position.x), y: Double(state.position.y))
    }

    public var pos: (x: Double, y: Double) {
        return position
    }

    public func towards(_ x: Double, y: Double) -> Double {
        let tan = (y - Double(state.position.y)) / (x - Double(state.position.x))
        return 90 - (atan(tan) * 180 / .pi)
    }

    public var xcor: Double {
        return Double(state.position.x)
    }

    public var ycor: Double {
        return Double(state.position.y)
    }

    public var heading: Double {
        return Double(state.heading)
    }

    public func distance(_ x: Double, y: Double) -> Double {
        let distanceX = x - Double(state.position.x)
        let distanceY = y - Double(state.position.y)
        return sqrt(pow(distanceX, 2) + pow(distanceY, 2))
    }

    public func random(_ max: Double) -> Double {
        let upperBound = UInt32(Swift.min(Swift.max(Int64(max), 0), Int64(UInt32.max)))
        return Double(arc4random_uniform(upperBound))
    }

}
