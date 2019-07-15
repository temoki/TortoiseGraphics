import CoreGraphics

class CommandClear: Command {

    func test(in state: State) -> State {
        return state
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
