import CoreGraphics

class CommandFill: Command {

    enum Operation {
        case begin
        case end
    }

    private let operation: Operation

    init(_ operation: Operation) {
        self.operation = operation
    }

    func test(in state: State) -> State {
        var newState = state
        switch operation {
        case .begin:
            newState.fillPath = CGMutablePath()
        case .end:
            newState.fillPath = nil
        }
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        var newState = state
        switch operation {
        case .begin:
            newState.fillPath = CGMutablePath()
            newState.fillPath?.move(to: newState.position)
        case .end:
            if let fillPath = newState.fillPath {
                context.saveGState()
                context.setFillColor(newState.fillColor)
                context.move(to: state.position)
                context.addPath(fillPath)
                context.fillPath(using: .evenOdd)
                newState.fillPath = nil
                context.restoreGState()
            }
        }
        return newState
    }

}
