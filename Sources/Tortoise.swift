import Foundation
import CoreGraphics

public class Tortoise {

    var tag: Int = 0

    var testState = State()

    var commands: [Command] = [CommandReset()]

    var commandedHandler: ((Tortoise) -> Void)?

    public init() {}

    func add(command: Command) {
        testState = command.test(in: testState)
        commands.append(command)
        commandedHandler?(self)
    }

    func initialize() {
        testState = State()
        commands = [CommandReset()]
        commandedHandler = nil
    }

    @discardableResult
    func draw(with context: GraphicsContext, toFrame index: Int?) -> Int {
        let endIndex = commands.count - 1
        let toIndex = min(max((index ?? endIndex), 0), endIndex)

        context.setup()

        var state = State()
        state.canvasSize = context.size

        for (index, command) in commands.enumerated() where index <= toIndex {
            state = command.exexute(in: state, with: context.cgContext)
        }

        if state.isVisible {
            drawTortoise(context.cgContext, state: state)
        }

        context.tearDown()
        return min(toIndex + 1, endIndex)
    }

    func drawTortoise(_ cgContext: CGContext, state: State) {
        cgContext.saveGState()
        cgContext.setLineWidth(state.penSize)
        cgContext.setStrokeColor(state.penColor)
        cgContext.setFillColor(state.fillColor)
        let transform = CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: -state.heading.radian.value)
        let path = CGMutablePath()
        path.addPath(state.shape.scaledPath(by: state.penSize * 10), transform: transform)
        path.closeSubpath()
        cgContext.addPath(path)
        cgContext.strokePath()
        cgContext.addPath(path)
        cgContext.fillPath()
        cgContext.restoreGState()
    }

}
