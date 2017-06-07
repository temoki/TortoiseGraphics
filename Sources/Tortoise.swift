import Foundation
import CoreGraphics

public class Tortoise {

    var testState = State()

    var commands: [Command] = [CommandReset()]

    var commandedHandler: ((Tortoise) -> Void)?

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
            .rotated(by: -state.heading.radian.value)
        cgContext.move(to: CGPoint(x:  0, y:  0).applying(transform))
        cgContext.addLine(to: CGPoint(x:  5, y: -10).applying(transform))
        cgContext.addLine(to: CGPoint(x:  0, y: -7.5).applying(transform))
        cgContext.addLine(to: CGPoint(x: -5, y: -10).applying(transform))
        cgContext.closePath()
        cgContext.setFillColor(state.penColor)
        cgContext.fillPath()
        cgContext.restoreGState()
    }

    // MARK: - Image

    func makeCGImage(of size: CGSize) -> CGImage? {
        let context = GraphicsContext.createBitmapContext(size: size)
        draw(with: context, toFrame: nil)
        return context.cgContext.makeImage()
    }

    func writeImage(size: CGSize, type: CFString, fileURL: CFURL) -> Bool {
        guard let cgImage = makeCGImage(of: size) else { return false }
        guard let destination = CGImageDestinationCreateWithURL(fileURL, type, 1, nil) else { return false }
        CGImageDestinationAddImage(destination, cgImage, nil)
        return CGImageDestinationFinalize(destination)
    }

    func writeAnimationImage(size: CGSize, type: CFString, fileURL: CFURL) -> Bool {
        guard let destination = CGImageDestinationCreateWithURL(fileURL, type, commands.count, nil) else { return false }
        for frameIndex in 0 ..< commands.count {
            let context = GraphicsContext.createBitmapContext(size: size)
            draw(with: context, toFrame: frameIndex)
            guard let cgImage = context.cgContext.makeImage() else { return false }
            CGImageDestinationAddImage(destination, cgImage, nil)
        }
        return CGImageDestinationFinalize(destination)
    }

}
