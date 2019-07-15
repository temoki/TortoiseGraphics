/*
import Foundation
import CoreGraphics

/// Tortoise motion
public extension Tortoise {

    // MARK: - Move and Draw

    func forward(_ distance: Double) {
        add(command: CommandForward(distance: CGFloat(distance)))
    }

    func fd(_ distance: Double) {
        forward(distance)
    }

    func backward(_ distance: Double) {
        forward(-distance)
    }

    func back(_ distance: Double) {
        backward(distance)
    }

    func bk(_ distance: Double) {
        backward(distance)
    }

    func right(_ angle: Double) {
        add(command: CommandRight(angle: CGFloat(angle)))
    }

    func rt(_ angle: Double) {
        right(angle)
    }

    func left(_ angle: Double) {
        add(command: CommandRight(angle: -CGFloat(angle)))
    }

    func lt(_ angle: Double) {
        left(angle)
    }

    func setPosition(_ x: Double, _ y: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: x, y: y)))
    }

    func setPos(_ x: Double, _ y: Double) {
        setPosition(x, y)
    }

    func goto(_ x: Double, _ y: Double) {
        setPosition(x, y)
    }

    func setX(_ x: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: CGFloat(x), y: testState.position.y)))
    }

    func setY(_ y: Double) {
        add(command: CommandSetPosition(position: CGPoint(x: testState.position.x, y: CGFloat(y))))
    }

    func setHeading(_ heading: Double) {
        add(command: CommandSetHeading(heading: CGFloat(heading)))
    }

    func setH(_ heading: Double) {
        setHeading(heading)
    }

    func home() {
        add(command: CommandHome())
    }

    func dot(_ size: Double? = nil) {
        add(command: CommandDot(size: size.map { CGFloat($0) }))
    }

    func circle(_ radius: Double, _ extent: Double = 360, _ steps: Int = 0) {
        add(command: CommandCircle(radius: CGFloat(radius), extent: CGFloat(extent), steps: steps))
    }

    func `repeat`(_ times: Int, _ block: () -> Void) {
        for _ in 1...times {
            block()
        }
    }

    // MARK: - Tell tortoise's state

    var position: Vec2D {
        return Vec2D(Double(testState.position.x), Double(testState.position.y))
    }

    var pos: Vec2D {
        return position
    }

    func towards(_ x: Double, _ y: Double) -> Double {
        let tan = CGFloat((y - Double(testState.position.y)) / (x - Double(testState.position.x)))
        return 90 - Double(Radian(atan(tan)).degree.value)
    }

    func towards(_ position: Vec2D) -> Double {
        return towards(position.x, position.y)
    }

    var xcor: Double {
        return Double(testState.position.x)
    }

    var ycor: Double {
        return Double(testState.position.y)
    }

    var heading: Double {
        return Double(testState.heading.value)
    }

    func distance(_ x: Double, _ y: Double) -> Double {
        let distanceX = x - Double(testState.position.x)
        let distanceY = y - Double(testState.position.y)
        return sqrt(pow(distanceX, 2) + pow(distanceY, 2))
    }

    func distance(_ position: Vec2D) -> Double {
        return distance(position.x, position.y)
    }

    func random(_ max: Double) -> Double {
        let upperBound = UInt32(Swift.min(Swift.max(Int64(max), 0), Int64(UInt32.max)))
        return Double(arc4random_uniform(upperBound))
    }

}
*/
