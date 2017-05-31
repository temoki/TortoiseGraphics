import CoreGraphics

class CommandPenColor: Command {

    private let color: CGColor

    init(_ color: Color) {
        self.color = color.cgColor
    }

    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.color = CGColor(red: red, green: green, blue: blue, alpha: 1)
    }

    func test(in state: State) -> State {
        var newState = state
        newState.penColor = color
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        context.setStrokeColor(newState.penColor)
        return newState
    }

}
