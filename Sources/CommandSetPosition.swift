import CoreGraphics

class CommandSetPosition: Command {

    private let position: CGPoint

    init(position: CGPoint) {
        self.position = position
    }

    func test(in state: State) -> State {
        var newState = state
        newState.position = position
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        if newState.isPenDown {
            context.addLine(to: newState.position)
            state.fillPath?.addLine(to: newState.position)
            context.strokePath()
        }
        context.move(to: newState.position)
        return newState
    }

}
