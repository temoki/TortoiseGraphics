import CoreGraphics

class CommandSetY: Command {

    private let y: CGFloat

    init(y: CGFloat) {
        self.y = y
    }

    func test(in state: State) -> State {
        var newState = state
        newState.position.y = y
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.move(to: newState.position)
        return newState
    }

}
