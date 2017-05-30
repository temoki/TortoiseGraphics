import Foundation
import CoreGraphics

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

}
