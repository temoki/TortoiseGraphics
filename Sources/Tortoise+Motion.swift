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
        add(command: CommandSetPosition(position: CGPoint(x: CGFloat(x), y: testState.position.y)))
    }

    public func setY(_ y: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: testState.position.x, y: CGFloat(y))))
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

    public func circle(_ radius: Double, _ extent: Double = 360, _ steps: Int = 0) {
        add(command: CommandCircle(radius: CGFloat(radius), extent: CGFloat(extent), steps: steps))
    }

    public func `repeat`(_ times: Int, _ block: () -> Void) {
        for _ in 1...times {
            block()
        }
    }

    // MARK: - Tell tortoise's state

    public var position: Vec2D {
        return Vec2D(Double(testState.position.x), Double(testState.position.y))
    }

    public var pos: Vec2D {
        return position
    }

    public func towards(_ x: Double, _ y: Double) -> Double {
        let tan = CGFloat((y - Double(testState.position.y)) / (x - Double(testState.position.x)))
        return 90 - Double(Radian(atan(tan)).degree.value)
    }

    public func towards(_ position: Vec2D) -> Double {
        return towards(position.x, position.y)
    }

    public var xcor: Double {
        return Double(testState.position.x)
    }

    public var ycor: Double {
        return Double(testState.position.y)
    }

    public var heading: Double {
        return Double(testState.heading.value)
    }

    public func distance(_ x: Double, _ y: Double) -> Double {
        let distanceX = x - Double(testState.position.x)
        let distanceY = y - Double(testState.position.y)
        return sqrt(pow(distanceX, 2) + pow(distanceY, 2))
    }

    public func distance(_ position: Vec2D) -> Double {
        return distance(position.x, position.y)
    }

    public func random(_ max: Double) -> Double {
        let upperBound = UInt32(Swift.min(Swift.max(Int64(max), 0), Int64(UInt32.max)))
        return Double(arc4random_uniform(upperBound))
    }

}
