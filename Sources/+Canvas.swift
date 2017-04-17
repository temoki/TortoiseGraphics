//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

/// Tortoise
final public class Canvas {

    /// Context
    private let context: Context

    // MARK: - Properties

    /// Tortoise
    public var tortoise: Tortoise {
        return context.procedures[Context.defaultProcedureName]!
    }

    /// Tortoise
    public var 🐢: Tortoise {
        return tortoise
    }

    /// Rendered canvas image
    public var rendered: CGImage? {
        return context.makeRenderedImage()
    }

    // MARK: - Initializer

    /// Initializer
    /// - parameter size: Canvas size
    /// - parameter tortoiseImage: Tortoise icon image
    public required init(size: CGSize, tortoiseImage: CGImage? = nil) {
        self.context = Context(canvasSize: size, tortoiseImage: tortoiseImage)
    }

    /// Initializer
    /// - parameter size: Canvas size
    /// - parameter tortoiseImage: Tortoise icon image
    public required init(context: CGContext, size: CGSize, tortoiseImage: CGImage? = nil) {
        self.context = Context(cgContext: context, canvasSize: size, tortoiseImage: tortoiseImage)
    }

    // MARK: - Methods

    /// Clear canvas
    public func clear() {
        context.reset()
        tortoise.clear()
    }

    /// Draw to canvas
    public func draw() {
        tortoise.doExecute(context: context)
        context.drawTortoise()
    }

}
