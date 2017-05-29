import CoreGraphics

class CommandSetX: Command {

    private let x: CGFloat

    init(x: CGFloat) {
        self.x = x
    }

    func test(in state: State) -> State {
        var newState = state
        newState.position.x = x
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.move(to: newState.position)
        return newState
    }

}
