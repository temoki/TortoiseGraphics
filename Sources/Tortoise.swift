//
//  Tortoise.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/15.
//

import Foundation
import CoreGraphics

public class Tortoise {

    public init(canvas: Canvas) {
        self.canvas = canvas
        delegate?.tortoiseDidInitialized(self.state)
    }

    // MARK: - [Motion] Move and Draw

    public func forward(_ distance: Double) {
        let transform = CGAffineTransform(translationX: CGFloat(state.position.x),
                                          y: CGFloat(state.position.y))
            .rotated(by: CGFloat(-state.heading.radian))
        let newPosition = CGPoint(x: 0, y: distance).applying(transform)
        setPosition(Double(newPosition.x), Double(newPosition.y))
    }

    public func backword(_ distance: Double) {
        forward(-distance)
    }

    public func right(_ angle: Double) {
        let newHeading = state.heading.degree + angle
        setHeading(newHeading)
    }

    public func left(_ angle: Double) {
        right(-angle)
    }

    public func setPosition(_ x: Double, _ y: Double) {
        let newPosition = Vec2D(x, y)
        state.position = newPosition
        state.fillPath?.append(newPosition)
        delegate?.tortoiseDidChangePosition(state)
    }

    public func setX(_ x: Double) {
        setPosition(x, Double(state.position.y))
    }

    public func setY(_ y: Double) {
        setPosition(Double(state.position.x), y)
    }

    public func setHeading(_ heading: Double) {
        state.heading = Degree(heading)
        delegate?.tortoiseDidChangeHeading(state)

    }

    public func home() {
        setPosition(0, 0)
        setHeading(0)
    }

    public func dot(_ size: Double? = nil) {
        // TODO: impl
    }

    public func circle(_ radius: Double, _ extent: Double = 360, _ steps: Int = 0) {
        let checkedExtent = max(min(extent, 360), 1)

        // Step
        let minSteps = max(Int(checkedExtent / 10), 1)
        let definedSteps = steps <= 0 ? minSteps : min(steps, minSteps)

        // Execute
        let baseAngle = (180 - checkedExtent / Double(definedSteps)) * 0.5
        let leftAngle1 = 90 - baseAngle
        let leftAngleN = 2 * leftAngle1
        let distance = 2 * radius * cos(Degree(baseAngle).radian)
        for index in 1 ... definedSteps {
            if index == 1 {
                right(-leftAngle1)
            } else {
                right(-leftAngleN)
            }
            forward(distance)
        }
        right(-leftAngle1)
    }

    public func speed(_ speed: Speed) {
        state.speed = speed
    }

    var speed: Speed {
        return state.speed
    }

    public func `repeat`(_ times: Int, _ block: () -> Void) {
        if times > 0 {
            (0 ..< times).forEach { _ in block() }
        }
    }

    // MARK: - [Motion] Tell tortoise's state

    public var position: Vec2D {
        return Vec2D(Double(state.position.x), Double(state.position.y))
    }

    public var pos: Vec2D {
        return position
    }

    public func towards(_ x: Double, _ y: Double) -> Double {
        let tan = (y - state.position.y) / (x - state.position.x)
        return 90 - Radian(atan(tan)).degree
    }

    public func towards(_ position: Vec2D) -> Double {
        return towards(position.x, position.y)
    }

    public var xcor: Double {
        return Double(state.position.x)
    }

    public var ycor: Double {
        return Double(state.position.y)
    }

    public var heading: Double {
        return Double(state.heading.value)
    }

    public func distance(_ x: Double, _ y: Double) -> Double {
        let distanceX = x - Double(state.position.x)
        let distanceY = y - Double(state.position.y)
        return sqrt(pow(distanceX, 2) + pow(distanceY, 2))
    }

    public func distance(_ position: Vec2D) -> Double {
        return distance(position.x, position.y)
    }

    public func random(_ max: Double) -> Double {
        let upperBound = UInt32(Swift.min(Swift.max(Int64(max), 0), Int64(UInt32.max)))
        return Double(arc4random_uniform(upperBound))
    }

    // MARK: - [Pen control] Drawing state

    public func penDown() {
        if !state.pen.isDown {
            state.pen.isDown = true
            delegate?.tortoiseDidChangePen(state)
        }
    }

    public func penUp() {
        if state.pen.isDown {
            state.pen.isDown = false
            delegate?.tortoiseDidChangePen(state)
        }
    }

    public func penSize(_ size: Double) {
        if state.pen.width != size {
            state.pen.width = size
            delegate?.tortoiseDidChangePen(state)
        }
    }

    public var isDown: Bool {
        return state.pen.isDown
    }

    public var penSize: Double {
        return Double(state.pen.width)
    }

    // MARK: - [Pen control] Color control

    public func penColor(_ color: Color) {
        state.pen.color = color.rgb
        delegate?.tortoiseDidChangePen(state)
    }

    public func penColor(_ r: Double, _ g: Double, _ b: Double) {
        state.pen.color = RGB(r, g, b)
        delegate?.tortoiseDidChangePen(state)
    }

    public func penColor(_ rgb: RGB) {
        state.pen.color = rgb
        delegate?.tortoiseDidChangePen(state)
    }

    public var penColor: RGB {
        return state.pen.color
    }

    public func fillColor(_ color: Color) {
        state.pen.fillColor = color.rgb
        delegate?.tortoiseDidChangePen(state)
    }

    public func fillColor(_ r: Double, _ g: Double, _ b: Double) {
        state.pen.fillColor = RGB(r, g, b)
        delegate?.tortoiseDidChangePen(state)
    }

    public func fillColor(_ rgb: RGB) {
        state.pen.fillColor = rgb
        delegate?.tortoiseDidChangePen(state)
    }

    public var fillColor: RGB {
        return state.pen.fillColor
    }

    // MARK: - [Pen Control] Filling

    public var filling: Bool {
        return state.fillPath != nil
    }

    public func beginFill() {
        state.fillPath = [state.position]
    }

    public func endFill() {
        delegate?.tortoiseDidRequestToFill(state)
        state.fillPath = nil
    }

    // MARK: - [Pen control] More drawing control

    public func reset() {
        state = TortoiseState()
        delegate?.tortoiseDidRequestToClear(state)
        delegate?.tortoiseDidInitialized(state)
    }

    public func clear() {
        delegate?.tortoiseDidRequestToClear(state)
    }

    // MARK: - [Tortoise state] Visiblity

    public func showTortoise() {
        if !state.shape.isVisible {
            state.shape.isVisible = true
            delegate?.tortoiseDidChangeShape(state)
        }
    }

    public func hideTortoise() {
        if state.shape.isVisible {
            state.shape.isVisible = false
            delegate?.tortoiseDidChangeShape(state)
        }
    }

    public var isVisible: Bool {
        return state.shape.isVisible
    }

    public func shape(_ shape: Shape) {
        if state.shape.name != shape.name {
            state.shape = shape
            delegate?.tortoiseDidChangeShape(state)
        }
    }

    public var shape: Shape {
        return state.shape
    }

    // MARK: - Internal

    var state: TortoiseState = TortoiseState()

    let canvas: Canvas

    var delegate: TortoiseDelegate? {
        return canvas as? TortoiseDelegate
    }

}
