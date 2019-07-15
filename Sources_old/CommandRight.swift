import CoreGraphics

class CommandRight: Command {

    private let angle: CGFloat

    init(angle: CGFloat) {
        self.angle = angle
    }

    func test(in state: State) -> State {
        var newState = state
        newState.heading = Degree(state.heading.value + angle)
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }

}
