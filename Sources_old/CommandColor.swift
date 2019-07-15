import CoreGraphics

class CommandColor: Command {

    enum ColorType {
        case pen
        case fill
    }

    private let type: ColorType
    private let color: CGColor

    init(_ type: ColorType, color: Color) {
        self.type = type
        self.color = color.cgColor
    }

    init(_ type: ColorType, red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.type = type
        self.color = CGColor.rgb(red, green, blue)
    }

    func test(in state: State) -> State {
        var newState = state
        switch type {
        case .pen:
            newState.penColor = color
        case .fill:
            newState.fillColor = color
        }
        return newState
    }

    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }

}
