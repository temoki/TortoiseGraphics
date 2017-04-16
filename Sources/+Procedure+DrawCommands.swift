//
//  Tortoise+DrawCommands.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/12.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

/// Procedure: Draw commands
public extension Procedure {

    // MARK: - clearScreen

    /// Clear the graphics screen and set the tortoise to its home position.
    /// The graphics screen is filled with the current background pen colour.
    /// The same as doing Clean followed by Home.
    public func clearScreen() -> Procedure {
        add(command: CommandClearScreen())
        return self
    }

    // MARK: - clean

    /// Clear the graphics screen without affecting the tortoise.
    /// The graphics screen is filled with the current background pen colour.
    public func clean() -> Procedure {
        add(command: CommandClean())
        return self
    }

    // MARK: - dot

    /// Put a dot of the current colour at position x y on the screen.
    /// Note that positive y-values go up the screen.
    /// - parameter x: X coordinate
    /// - parameter y: Y coordinate
    /// - returns: self
    public func dot(_ x: @escaping NumberOutput, _ y: @escaping NumberOutput) -> Procedure {
        add(command: CommandDot(x: x, y: y))
        return self
    }

    /// Put a dot of the current colour at position x y on the screen.
    /// Note that positive y-values go up the screen.
    /// - parameter x: X coordinate
    /// - parameter y: Y coordinate
    /// - returns: self
    public func dot(_ x: Number, _ y: Number) -> Procedure {
        return dot({_ in x}, {_ in y})
    }

    // MARK: - arc

    /// Draws an arc of radius radius,
    /// entred on the current tortoise position and starting
    /// at the current heading, sweeping clockwise through angle angle.
    /// Draws a line if the pen is down.
    /// - parameter angle: Angle (degree)
    /// - parameter radius: Radius
    /// - returns: self
    public func arc(_ angle: @escaping NumberOutput, _ radius: @escaping NumberOutput) -> Procedure {
        add(command: CommandArc(angle: angle, radius: radius))
        return self
    }

    /// Draws an arc of radius radius,
    /// entred on the current tortoise position and starting
    /// at the current heading, sweeping clockwise through angle angle.
    /// Draws a line if the pen is down.
    /// - parameter angle: Angle (degree)
    /// - parameter radius: Radius
    /// - returns: self
    public func arc(_ angle: Number, _ radius: Number) -> Procedure {
        return arc({_ in angle}, {_ in radius})
    }

}
