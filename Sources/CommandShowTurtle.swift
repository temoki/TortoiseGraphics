import CoreGraphics

class CommandShowTortoise: Command {

    private let show: Bool

    init(_ show: Bool) {
        self.show = show
    }

    func test(in state: State) -> State {
        var newState = state
        newState.isVisible = show
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }

}
