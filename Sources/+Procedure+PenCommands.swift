//
//  Tortoise+PenCommands.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

/// Procedure: Pen commands
public extension Procedure {

    // MARK: - penDown

    /// Put the pen into draw state.
    /// If the tortoise moves, it will draw a line.
    /// - returns: self
    @discardableResult
    public func penDown() -> Procedure {
        add(command: CommandPenDown(true))
        return self
    }

    // MARK: - penUp

    /// Put the pen into non-draw state.
    /// - returns: self
    @discardableResult
    public func penUp() -> Procedure {
        add(command: CommandPenDown(false))
        return self
    }

    // MARK: - setPenColor

    /// Set the drawing colour to colour-number.
    /// This is the colour number used to draw lines and do fills.
    /// Use setRGB to set this colour number to a particular colour value.
    /// - parameter number: Color number
    /// - returns: self
    @discardableResult
    public func setPenColor(_ number: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetPenColor(number: number))
        return self
    }

    /// Set the drawing colour to colour-number.
    /// This is the colour number used to draw lines and do fills.
    /// Use setRGB to set this colour number to a particular colour value.
    /// - parameter number: Color number
    /// - returns: self
    @discardableResult
    public func setPenColor(_ number: Number) -> Procedure {
        return setPenColor({_ in number})
    }

    // MARK: - setPenWidth

    /// Set the width of the pen to width.
    /// New lines are drawn with this width.
    /// - parameter width: Pen width
    /// - returns: self
    @discardableResult
    public func setPenWidth(_ width: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetPenWidth(width))
        return self
    }

    /// Set the width of the pen to width.
    /// New lines are drawn with this width.
    /// - parameter width: Pen width
    /// - returns: self
    public func setPenWidth(_ width: Number) -> Procedure {
        return setPenWidth({_ in width})
    }

    // MARK: - setLineCap

    /// Sets the end style for lines to line-end-style,
    /// which can be butt (the default), round, or square.
    /// The following diagram shows how the line ending varies for each of the options.
    /// The red dashed lines show where the lines end.
    /// - parameter lineCap: Line cap
    /// - returns: self
    @discardableResult
    public func setLineCap(_ lineCap: LineCap) -> Procedure {
        add(command: CommandSetLineCap(lineCap))
        return self
    }

    // MARK: - setLineDash

    /// Sets the line dash pattern for drawn lines.
    /// drawn-dash-1 is the length, in pixels, of the first, drawn, part of the line.
    /// empty-dash-1 is the length of the first blank part of the line.
    /// The pattern is then repeated. phase is how far into the pattern the line starts drawing.
    /// - parameter phase: Phase
    /// - parameter dashLengths: Dash lengths (drawn-dash-1, empty-dash-1, drawn-dash-2, ...)
    /// - returns: self
    @discardableResult
    public func setLineDash(_ phase: @escaping NumberOutput, _ dashLengths: [NumberOutput]) -> Procedure {
        add(command: CommandSetLineDash(phase: phase, dashLengths: dashLengths))
        return self
    }

    /// Sets the line dash pattern for drawn lines.
    /// drawn-dash-1 is the length, in pixels, of the first, drawn, part of the line.
    /// empty-dash-1 is the length of the first blank part of the line.
    /// The pattern is then repeated. phase is how far into the pattern the line starts drawing.
    /// - parameter phase: Phase
    /// - parameter dashLengths: Dash lengths (drawn-dash-1, empty-dash-1, drawn-dash-2, ...)
    /// - returns: self
    @discardableResult
    public func setLineDash(_ phase: Number, _ dashLengths: [Number]) -> Procedure {
        let numberOutputs = dashLengths.map { (dashLength) -> NumberOutput in
            return {(_) in dashLength}
        }
        return setLineDash({_ in phase}, numberOutputs)
    }

    // MARK: - setBackground

    /// Set the background colour to colour-number.
    /// This colour will be used when ClearScreen or Clean is called.
    /// - parameter number: Color number
    /// - returns: self
    @discardableResult
    public func setBackground(_ number: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetBackground(number: number))
        return self
    }

    /// Set the background colour to colour-number.
    /// This colour will be used when ClearScreen or Clean is called.
    /// - parameter number: Color number
    /// - returns: self
    @discardableResult
    public func setBackground(_ number: Number) -> Procedure {
        return setBackground({_ in number})
    }

    // MARK: - setRGB

    /// Set red, green, and blue components of colour colour-number to red, green, blue.
    /// Each component is a number between 0.0 and 1.0. 0.0 means that
    /// none of that component is present,  while 1.0 means all of it is present.
    /// So, [1.0 0.0 0.0] is a bright red and [0.0 0.0 1.0] is a bright blue.
    /// Black is [0.0 0.0 0.0] and white is [1.0 1.0 1.0].
    /// If opacity is specified, the colour has the specified opacity -
    /// 0.0 is completely transparent, 1.0 is completely opaque.
    /// - parameter number: Color number
    /// - parameter componets: RGB and Opacity components
    /// - returns: self
    @discardableResult
    public func setRGB(_ number: @escaping NumberOutput, _ components: [NumberOutput]) -> Procedure {
        add(command: CommandSetRGB(number: number, components: components))
        return self
    }

    /// Set red, green, and blue components of colour colour-number to red, green, blue.
    /// Each component is a number between 0.0 and 1.0. 0.0 means that
    /// none of that component is present,  while 1.0 means all of it is present.
    /// So, [1.0 0.0 0.0] is a bright red and [0.0 0.0 1.0] is a bright blue.
    /// Black is [0.0 0.0 0.0] and white is [1.0 1.0 1.0].
    /// If opacity is specified, the colour has the specified opacity -
    /// 0.0 is completely transparent, 1.0 is completely opaque.
    /// - parameter number: Color number
    /// - parameter componets: RGB and Opacity components
    /// - returns: self
    @discardableResult
    public func setRGB(_ number: Number, _ components: [Number]) -> Procedure {
        let numberOutputs = components.map { (component) -> NumberOutput in
            return {(_) in component}
        }
        return setRGB({_ in number}, numberOutputs)
    }

}
