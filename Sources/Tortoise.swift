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
        let transform = CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: -state.heading.radian)
        let newPosition = CGPoint(x: 0, y: distance).applying(transform)
        setPosition(Double(newPosition.x), Double(newPosition.y))
    }

    public func backword(_ distance: Double) {
        forward(-distance)
    }

    public func right(_ angle: Double) {
        let newHeading = state.heading.degree + CGFloat(angle)
        setHeading(Double(newHeading))
    }

    public func left(_ angle: Double) {
        right(-angle)
    }

    public func setPosition(_ x: Double, _ y: Double) {
        let newPosition = CGPoint(x: x, y: y)
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
        state.heading = Degree(CGFloat(heading))
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
        // Radius
        let radiusf = CGFloat(radius)

        // Extent
        let extentf = CGFloat(max(min(extent, 360), 1))

        // Step
        let minSteps = max(Int(extentf / 10), 1)
        let definedSteps = steps <= 0 ? minSteps : min(steps, minSteps)

        // Execute
        let baseAngle = (180 - extentf / CGFloat(definedSteps)) * 0.5
        let leftAngle1 = Double(90 - baseAngle)
        let leftAngleN = Double(2 * leftAngle1)
        let distance = Double(2 * radiusf * cos(Degree(baseAngle).radian))
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
        let tan = CGFloat((y - Double(state.position.y)) / (x - Double(state.position.x)))
        return 90 - Double(Radian(atan(tan)).degree)
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
        let castedSize = CGFloat(size)
        if state.pen.width != castedSize {
            state.pen.width = castedSize
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
        state.pen.color = color.cgColor
        delegate?.tortoiseDidChangePen(state)
    }

    public func penColor(_ r: Double, _ g: Double, _ b: Double) {
        state.pen.color = CGColor.rgb(CGFloat(r/255), CGFloat(g/255), CGFloat(b/255))
        delegate?.tortoiseDidChangePen(state)
    }

    public func penColor(_ rgb: (r: Double, g: Double, b: Double)) {
        state.pen.color = CGColor.rgb(CGFloat(rgb.r/255), CGFloat(rgb.g/255), CGFloat(rgb.b/255))
        delegate?.tortoiseDidChangePen(state)
    }

    public var penColor: (r: Double, g: Double, b: Double) {
        let rgb = state.pen.color.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    public func fillColor(_ color: Color) {
        state.pen.fillColor = color.cgColor
        delegate?.tortoiseDidChangePen(state)
    }

    public func fillColor(_ r: Double, _ g: Double, _ b: Double) {
        state.pen.fillColor = CGColor.rgb(CGFloat(r/255), CGFloat(g/255), CGFloat(b/255))
        delegate?.tortoiseDidChangePen(state)
    }

    public func fillColor(_ rgb: (r: Double, g: Double, b: Double)) {
        state.pen.fillColor = CGColor.rgb(CGFloat(rgb.r/255), CGFloat(rgb.g/255), CGFloat(rgb.b/255))
        delegate?.tortoiseDidChangePen(state)
    }

    public var fillColor: (r: Double, g: Double, b: Double) {
        let rgb = state.pen.fillColor.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    // MARK: - [Pen Control] Filling

    public var filling: Bool {
        return state.fillPath != nil
    }

    public func beginFill() {
        state.fillPath = [state.position]
    }

    public func endFill() {
        delegate?.tortoiseDidRequestFilling(state)
        state.fillPath = nil
    }

    // MARK: - [Pen control] More drawing control

    public func reset() {
        // TODO: impl
    }

    public func clear() {
        // TODO: impl
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
