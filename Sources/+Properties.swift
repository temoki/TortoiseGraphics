//
//  Properties.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/15.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

// swiftlint:disable variable_name

/// Properties
public class Properties {

    /// Context
    private let context: Context

    /// Initializer
    /// - parameter context: Context
    internal init(context: Context) {
        self.context = context
    }

    // MARK: - Variable

    /// Refer variable
    public subscript(variableName: String) -> Number {
        get {
            for variables in context.variablesStack.reversed() {
                if let value = variables[variableName] {
                    return value
                }
            }
            fatalError("Variable [\(variableName)] is not declared.")
        }
    }

    // MARK: - Calculation

    /// Output a random integer between zero and number.
    /// - parameter max: Max number
    /// - returns: Random number
    public func random(_ max: Number) -> Number {
        let upperBound = UInt32(Swift.min(Swift.max(Int64(max.integer), 0), Int64(UInt32.max)))
        return Number(arc4random_uniform(upperBound))
    }

    /// Output the angle which the tortoiseʼs heading must be set to to point towards position x,y.
    /// - parameter x: Towards position x
    /// - parameter y: Towards position y
    /// - returns: Angle
    public func towards(_ x: Number, _ y: Number) -> Number {
        let tan = (y - context.position.y) / (x - context.position.x)
        return atan(tan).degree
    }

    // MARK: - Tortoise properties

    /// Shown
    public var shown: Bool {
        return context.showTortoise
    }

    /// Output the heading angle of the tortoise.
    /// This is the angle the tortoise faces,
    /// and the angle it will move in if the Forward command is used.
    /// A heading of zero is facing straight up.
    /// The heading increases in a clockwise direction - a heading of 90 is pointing to the right,
    /// 180 is pointing straight down, 270 is pointing to the left.
    /// When the heading reaches 360, it is reset to zero.
    public var heading: Number {
        return context.heading
    }

    /// Output a list containing the tortoiseʼs x and y co-ordinates.
    public var position: (x: Number, y: Number) {
        return (x: context.position.x, y: context.position.y)
    }

    /// Output the size of the drawing pen.
    /// This determines the width of lines that are drawn by the tortoise.
    public var penWidth: Number {
        return context.penWidth
    }

    /// Output the Pen colour number.
    /// This is the colour number which will be used when lines are drawn or fills are done.
    /// At startup, the Pen colour is set to 1.
    public var penColor: Number {
        return Number(context.penColor)
    }

    /// Output the number of the background colour.
    /// This is the colour used to fill the graphics window when ClearScreen is called.
    /// At startup, the background colour is set to zero.
    /// This is initially white, but can be changed with SetRGB.
    public var background: Number {
        return Number(context.backgroundColor)
    }

    /// Output the red, green, and blue components of colour colour-number.
    /// Each component is a number between 0.0 and 1.0.
    /// Because of the way colours are held within macOS,
    /// the values returned from RGB may be slightly different from those set with SetRGB.
    public func rgb(_ number: Number) -> [Number] {
        return context.colorPalette.color(number: number.integer).components
    }

    /// Outputs the width and height of the canvas (drawing area) as a list.
    public var canvasSize: (width: Number, height: Number) {
        return (width: context.canvasRect.size.width, height: context.canvasRect.size.height)
    }

}

// swiftlint:enable variable_name
