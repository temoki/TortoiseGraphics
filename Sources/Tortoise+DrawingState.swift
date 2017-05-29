import Foundation
import CoreGraphics

public extension Tortoise {

    // MARK: - Drawing State

    public func penDown() {
        add(command: CommandPenDown(true))
    }

    public func pd() {
        penDown()
    }

    public func down() {
        penDown()
    }

    public func penUp() {
        add(command: CommandPenDown(false))
    }

    public func pu() {
        penUp()
    }

    public func up() {
        penUp()
    }

    public func penSize(_ size: Double) {
        add(command: CommandPenSize(CGFloat(size)))
    }

    public func width(_ width: Double) {
        penSize(width)
    }

    var isDown: Bool {
        return state.isPenDown
    }

    var penSize: Double {
        return Double(state.penSize)
    }

    var width: Double {
        return penSize
    }

}
