//
//  TortoisePlayground.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/08.
//
//

import Foundation
import CoreGraphics

public class TortoisePlayground {

    public static var main: TortoisePlayground = {
        return TortoisePlayground()
    }()

    public let liveView = CanvasView(canvasSize: CGSize(width: 100, height: 100))

    private var timer: Timer?

    private var completionHandler: (() -> Void)?

    private var drawingStack = DrawingStack()

    public func start(withTimeInterval interval: TimeInterval) {
        guard timer == nil else { return }
        completionHandler = nil
        timer = Timer.scheduledTimer(timeInterval: max(interval, 0.01),
                                     target: self,
                                     selector: #selector(onTimer(timer:)),
                                     userInfo: nil,
                                     repeats: true)
    }

    public func finish(competion: @escaping () -> Void) {
        completionHandler = competion
    }

    @objc func onTimer(timer: Timer) {
        if let image = drawingStack.pop() {
            liveView.draw(image: image)
            return
        }

        if let handler = completionHandler {
            self.timer?.invalidate()
            self.timer = nil
            handler()
            self.completionHandler = nil
        }
    }

    func execute(command: Command) {
        command.execute(context: liveView.canvas.context)
        guard command.isGraphicsCommand else { return }
        guard let image = liveView.canvas.context.render() else { return }
        drawingStack.push(image)
    }

}

// MARK: - Control Commands

public func showTortoise() {
    TortoisePlayground.main.execute(command: CommandShowTortoise(show: true))
}

public func hideTortoise() {
    TortoisePlayground.main.execute(command: CommandShowTortoise(show: false))
}

// MARK: - Draw Commands

public func clearScreen() {
    TortoisePlayground.main.execute(command: CommandClearScreen())
}

public func clean() {
    TortoisePlayground.main.execute(command: CommandClean())
}

public func dot(_ x: Number, _ y: Number) {
    TortoisePlayground.main.execute(command: CommandDot(x: {_ in x}, y: {_ in y}))
}

public func arc(_ angle: Number, _ radius: Number) {
    TortoisePlayground.main.execute(command: CommandArc(angle: {_ in angle}, radius: {_ in radius}))
}

// MARK: - Move Commands

public func forward(_ distance: Number) {
    TortoisePlayground.main.execute(command: CommandForward(distance: {_ in distance}))
}

public func back(_ distance: Number) {
    TortoisePlayground.main.execute(command: CommandBack(distance: {_ in distance}))
}

public func right(_ angle: Number) {
    TortoisePlayground.main.execute(command: CommandRight(angle: {_ in angle}))
}

public func left(_ angle: Number) {
    TortoisePlayground.main.execute(command: CommandLeft(angle: {_ in angle}))
}

public func home() {
    TortoisePlayground.main.execute(command: CommandHome())
}

public func setHeading(_ angle: Number) {
    TortoisePlayground.main.execute(command: CommandSetHeading(angle: {_ in angle}))
}

public var heading: Number {
    return Properties(context: TortoisePlayground.main.liveView.canvas.context).heading
}

public func setPosition(_ x: Number, _ y: Number) {
    TortoisePlayground.main.execute(command: CommandSetPosition(x: {_ in x}, y: {_ in y}))
}

public var position: (x: Number, y: Number) {
    return Properties(context: TortoisePlayground.main.liveView.canvas.context).position
}

public func setX(_ x: Number) {
    TortoisePlayground.main.execute(command: CommandSetX({_ in x}))
}

public func setY(_ y: Number) {
    TortoisePlayground.main.execute(command: CommandSetY({_ in y}))
}

public func towards(_ x: Number, _ y: Number) -> Number {
    return Properties(context: TortoisePlayground.main.liveView.canvas.context).towards(x, y)
}

// MARK: - Pen Commands

public func penDown() {
    TortoisePlayground.main.execute(command: CommandPenDown(true))
}

public func penUp() {
    TortoisePlayground.main.execute(command: CommandPenDown(false))
}

public func setPenWidth(_ width: Number) {
    TortoisePlayground.main.execute(command: CommandSetPenWidth({_ in width}))
}

public var penWidth: Number {
    return Properties(context: TortoisePlayground.main.liveView.canvas.context).penWidth
}

public func setPenColor(_ number: Number) {
    TortoisePlayground.main.execute(command: CommandSetPenColor(number: {_ in number}))
}

public var penColor: Number {
    return Properties(context: TortoisePlayground.main.liveView.canvas.context).penColor
}

// MARK: - Other Commands

public func random(max: Number) -> Number {
    return Properties(context: TortoisePlayground.main.liveView.canvas.context).random(max)
}
