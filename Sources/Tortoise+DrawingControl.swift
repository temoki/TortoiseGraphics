import Foundation

public extension Tortoise {

    // MARK: - Drawing Control

    public func `repeat`(_ times: Int, _ block: () -> Void) {
        for _ in 1...times {
            block()
        }
    }

    // TODO: reset() - Delete the turtle’s drawings from the screen, re-center the turtle and set variables to the default values.

    // TODO: clear() - Delete the turtle’s drawings from the screen. Do not move turtle. State and position of the turtle as well as drawings of other turtles are not affected.

}
