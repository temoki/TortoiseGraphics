//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

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
    /// - parameter width: Canvas width
    /// - parameter height: Canvas height
    /// - parameter tortoiseImage: Tortoise icon image
    public required init(width: Number, height: Number, tortoiseImage: CGImage? = nil) {
        context = Context(canvasSize: CGSize(width: width, height: height),
                          tortoiseImage: tortoiseImage)
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
