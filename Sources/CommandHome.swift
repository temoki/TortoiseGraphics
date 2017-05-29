import CoreGraphics

class CommandHome: Command {

    func test(in state: State) -> State {
        var newState = state
        let defaultState = State()
        newState.position = defaultState.position
        newState.heading = defaultState.heading
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.move(to: newState.position)
        return newState
    }

}
