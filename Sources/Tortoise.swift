import Foundation
import CoreGraphics

public class Tortoise {

    var state = State()

    var commands: [Command] = [CommandReset()]

    var commandedHandler: ((Tortoise) -> Void)?

    func add(command: Command) {
        state = command.test(in: state)
        commands.append(command)
        commandedHandler?(self)
    }

    @discardableResult
    func draw(with context: GraphicsContext, toFrame index: Int?) -> Int {
        let endIndex = commands.count - 1
        let toIndex = min(max((index ?? endIndex), 0), endIndex)

        context.setup()

        var state = State()
        state.canvasSize = context.size
        state.apply(to: context.cgContext)

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
        let transform = CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: Degree(-state.heading).radian)
        cgContext.move(to: CGPoint(x:  0, y:  5).applying(transform))
        cgContext.addLine(to: CGPoint(x:  5, y: -5).applying(transform))
        cgContext.addLine(to: CGPoint(x:  0, y: -3).applying(transform))
        cgContext.addLine(to: CGPoint(x: -5, y: -5).applying(transform))
        cgContext.closePath()
        cgContext.setFillColor(state.penColor)
        cgContext.fillPath()
        cgContext.restoreGState()
    }

}
