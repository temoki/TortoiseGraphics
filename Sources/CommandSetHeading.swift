import CoreGraphics

class CommandSetHeading: Command {

    private let heading: CGFloat

    init(heading: CGFloat) {
        self.heading = heading
    }

    func test(in state: State) -> State {
        var newState = state
        newState.heading = Degree(heading)
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }

}
