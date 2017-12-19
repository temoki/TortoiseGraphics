import CoreGraphics

class CommandReset: Command {

    func test(in state: State) -> State {
        var newState = State()
        newState.canvasSize = state.canvasSize
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.saveGState()
        context.setBlendMode(.clear)
        context.fill(CGRect(x: -newState.canvasSize.width*0.5,
                            y: -newState.canvasSize.height*0.5,
                            width: newState.canvasSize.width,
                            height: newState.canvasSize.height))
        context.restoreGState()
        return newState
    }

}
