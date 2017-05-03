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

    /// Canvas size
    public var size: CGSize {
        return context.canvasRect.size
    }

    // MARK: - Initializer

    /// Initializer
    /// - parameter size: Canvas size
    /// - parameter scale: Canvas scale
    /// - parameter tortoise: Tortoise icon image
    public required init(size: CGSize, scale: CGFloat = 1, tortoise image: CGImage? = nil) {
        self.context = Context(canvasSize: size, canvasScale: scale, tortoise: image)
    }

    // MARK: - Methods

    /// Clear canvas
    public func clear() {
        context.reset()
        tortoise.clear()
    }
    
    /// Set canvas size/scale
    /// - parameter size: Canvas size
    /// - parameter scale: Canvas scale
    public func setCanvas(size: CGSize, scale: CGFloat = 1) {
        context.setCanvas(size: size, scale: scale)
    }
    
    /// Set tortoise image
    /// - parameter tortoise: Tortoise icon image
    public func setTortoise(image: CGImage?) {
        context.tortoiseImage = image
    }

    /// Draw by executing all commands
    public func draw() -> CGImage? {
        context.drawingHandler = nil
        tortoise.doExecute(context: context)
        return context.render()
    }

    /// Draw by executing commands one by one
    public func draw(oneByOne handler: @escaping DrawingHandler) {
        context.drawingHandler = handler
        tortoise.doExecute(context: context)
        context.drawingHandler = nil
    }

}
