import CoreGraphics

class CommandReset: Command {

    func test(in state: State) -> State {
        var newState = State()
        newState.canvasSize = state.canvasSize
        newState.canvasColor = state.canvasColor
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.setFillColor(newState.canvasColor)
        context.fill(CGRect(x: -newState.canvasSize.width*0.5,
                            y: -newState.canvasSize.height*0.5,
                            width: newState.canvasSize.width,
                            height: newState.canvasSize.height))
        newState.apply(to: context)
        return newState
    }

}
