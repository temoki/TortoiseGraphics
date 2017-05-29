import Foundation

public extension Tortoise {

    // MARK: - Tortoise's Visiblity

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
        return state.isVisible
    }

}
