import CoreGraphics

class CommandShape: Command {

    private let shape: Shape

    init(_ shape: Shape) {
        self.shape = shape
    }

    func test(in state: State) -> State {
        var newState = state
        newState.shape = shape
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }

}
