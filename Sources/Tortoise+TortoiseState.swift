import Foundation

public extension Tortoise {

    // MARK: - Visiblity

    public func showTortoise() {
        add(command: CommandShowTortoise(true))
    }

    public func st() {
        showTortoise()
    }

    public func hideTortoise() {
        add(command: CommandShowTortoise(false))
    }

    public func ht() {
        hideTortoise()
    }

    public var isVisible: Bool {
        return testState.isVisible
    }

    public func shape(_ shape: Shape) {
        add(command: CommandShape(shape))
    }

    public var shape: String {
        return testState.shape.name
    }

}
