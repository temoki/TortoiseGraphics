import CoreGraphics

class CommandForward: Command {

    private let distance: CGFloat

    init(distance: CGFloat) {
        self.distance = distance
    }

    // MARK: - TortoiseCommand protocol

    func test(in state: State) -> State {
        var newState = state
        let transform = CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: -state.heading.radian.value)
        newState.position = CGPoint(x: 0, y: distance).applying(transform)
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        if newState.isPenDown {
            context.saveGState()
            context.setStrokeColor(newState.penColor)
            context.setLineWidth(newState.penSize)
            context.move(to: state.position)
            context.addLine(to: newState.position)
            context.strokePath()
            context.restoreGState()
            state.fillPath?.addLine(to: newState.position)
        }
        context.move(to: newState.position)
        return newState
    }

}
