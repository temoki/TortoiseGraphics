//
//  Tortoise+MoveCommands.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

/// Procedure: Move commands
public extension Procedure {

    // MARK: - forward

    /// Move the tortoise forward distance pixels.
    /// If the pen is down, a line is drawn.
    /// - parameter distance: Distance
    /// - returns: self
    @discardableResult
    public func forward(_ distance: @escaping NumberOutput) -> Procedure {
        add(command: CommandForward(distance: distance))
        return self
    }

    /// Move the tortoise forward distance pixels.
    /// If the pen is down, a line is drawn.
    /// - parameter distance: Distance
    /// - returns: self
    @discardableResult
    public func forward(_ distance: Number) -> Procedure {
        return forward({_ in distance})
    }

    // MARK: - back

    /// Move the tortoise backwards distance pixels.
    /// Draws a line if the pen is down.
    /// - parameter distance: Distance
    /// - returns: self
    @discardableResult
    public func back(_ distance: @escaping NumberOutput) -> Procedure {
        add(command: CommandBack(distance: distance))
        return self
    }

    /// Move the tortoise backwards distance pixels.
    /// Draws a line if the pen is down.
    /// - parameter distance: Distance
    /// - returns: self
    @discardableResult
    public func back(_ distance: Number) -> Procedure {
        return back({_ in distance})
    }

    // MARK: - right

    /// Rotate the tortoise clockwise through angle degrees.
    /// - parameter angle: Angle (degree)
    /// - returns: self
    @discardableResult
    public func right(_ angle: @escaping NumberOutput) -> Procedure {
        add(command: CommandRight(angle: angle))
        return self
    }

    /// Rotate the tortoise clockwise through angle degrees.
    /// - parameter angle: Angle (degree)
    /// - returns: self
    @discardableResult
    public func right(_ angle: Number) -> Procedure {
        return right({_ in angle})
    }

    // MARK: - left

    /// Rotate the tortoise anti-clockwise through angle degrees.
    /// - parameter angle: Angle (degree)
    /// - returns: self
    @discardableResult
    public func left(_ angle: @escaping NumberOutput) -> Procedure {
        add(command: CommandLeft(angle: angle))
        return self
    }

    /// Rotate the tortoise anti-clockwise through angle degrees.
    /// - parameter angle: Angle (degree)
    /// - returns: self
    @discardableResult
    public func left(_ angle: Number) -> Procedure {
        return left({_ in angle})
    }

    // MARK: - home

    /// Move the tortoise to the middle of the screen (position [0 0])
    /// and set its heading to zero (pointing straight up).
    /// - returns: self
    @discardableResult
    public func home() -> Procedure {
        add(command: CommandHome())
        return self
    }

    // MARK: - setHeading

    /// Set the tortoise heading to angle.
    /// The heading is the direction in which the tortoise is pointing.
    /// Straight up is a heading of zero.
    /// The heading increases as you go clockwise - straight down is 180.
    /// - parameter angle: Angle (degree)
    /// - returns: self
    @discardableResult
    public func setHeading(_ angle: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetHeading(angle: angle))
        return self
    }

    /// Set the tortoise heading to angle.
    /// The heading is the direction in which the tortoise is pointing.
    /// Straight up is a heading of zero.
    /// The heading increases as you go clockwise - straight down is 180.
    /// - parameter angle: Angle (degree)
    /// - returns: self
    @discardableResult
    public func setHeading(_ angle: Number) -> Procedure {
        return setHeading({_ in angle})
    }

    // MARK: - setPosition

    /// Move the tortoise to position x,y.
    /// If the pen is down, a line is drawn in the current colour.
    /// - parameter x: X coordinate
    /// - parameter y: Y coordinate
    /// - returns: self
    @discardableResult
    public func setPosition(_ x: @escaping NumberOutput, _ y: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetPosition(x: x, y: y))
        return self
    }

    /// Move the tortoise to position x,y.
    /// If the pen is down, a line is drawn in the current colour.
    /// - parameter x: X coordinate
    /// - parameter y: Y coordinate
    /// - returns: self
    @discardableResult
    public func setPosition(_ x: Number, _ y: Number) -> Procedure {
        return setPosition({_ in x}, {_ in y})
    }

    // MARK: - setX

    /// Set the x-co-ordinate of the tortoise to x.
    /// Draws a line if the pen is down.
    /// - parameter x: X coordinate
    /// - returns: self
    @discardableResult
    public func setX(_ x: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetX(x))
        return self
    }

    /// Set the x-co-ordinate of the tortoise to x.
    /// Draws a line if the pen is down.
    /// - parameter x: X coordinate
    /// - returns: self
    @discardableResult
    public func setX(_ x: Number) -> Procedure {
        return setX({_ in x})
    }

    // MARK: - setY

    /// Set the y-co-ordinate of the tortoise to y.
    /// Draws a line if the pen is down.
    /// - parameter y: Y coordinate
    /// - returns: self
    @discardableResult
    public func setY(_ y: @escaping NumberOutput) -> Procedure {
        add(command: CommandSetY(y))
        return self
    }

    /// Set the y-co-ordinate of the tortoise to y.
    /// Draws a line if the pen is down.
    /// - parameter y: Y coordinate
    /// - returns: self
    @discardableResult
    public func setY(_ y: Number) -> Procedure {
        return setY({_ in y})
    }

}
