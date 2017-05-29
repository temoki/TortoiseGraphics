import CoreGraphics

class CommandPenSize: Command {

    private let size: CGFloat

    init(_ size: CGFloat) {
        self.size = size
    }

    func test(in state: State) -> State {
        var newState = state
        newState.penSize = size
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.setLineWidth(newState.penSize)
        return newState
    }

}
