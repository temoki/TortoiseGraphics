import Foundation

public extension Tortoise {

    // MARK: - Visiblity

    func showTortoise() {
        add(command: CommandShowTortoise(true))
    }

    func st() {
        showTortoise()
    }

    func hideTortoise() {
        add(command: CommandShowTortoise(false))
    }

    func ht() {
        hideTortoise()
    }

    var isVisible: Bool {
        return testState.isVisible
    }

    func shape(_ shape: Shape) {
        add(command: CommandShape(shape))
    }

    var shape: String {
        return testState.shape.name
    }

}
