import CoreGraphics

class CommandPenDown: Command {

    private let penDown: Bool

    init(_ penDown: Bool) {
        self.penDown = penDown
    }

    func test(in state: State) -> State {
        var newState = state
        newState.isPenDown = penDown
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }

}
