//
//  Context.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class Context {

    // MARK: - Defaults

    static let defaultShowTortoise = true
    static let defaultBackgroundColor = 0
    static let defaultPosition = CGPoint.zero
    static let defaultHeading = Number(90)
    static let defaultPenDown = true
    static let defaultPenColor = 1
    static let defaultPenWidth = Number(1)
    static var defaultVariableStack: [[String: Number]] { return [[:]] }
    static let defaultProcedureName = "🐢"
    static var defaultProcedures: [String: Procedure] { return [defaultProcedureName: Procedure()] }

    // MARK: - Properties

    let canvasRect: CGRect

    var scaledCanvasRect: CGRect {
        return canvasRect.applying(CGAffineTransform(scaleX: canvasScale, y: canvasScale))
    }

    let bitmapContext: CGContext

    let canvasScale: CGFloat

    let colorPalette: ColorPalette

    let tortoiseImage: CGImage?

    var showTortoise: Bool

    var backgroundColor: Int

    var position: CGPoint {
        didSet {
            bitmapContext.move(to: position)
        }
    }

    var heading: Number

    var penDown: Bool

    var penColor: Int {
        didSet {
            let color = colorPalette.color(number: penColor)
            bitmapContext.setStrokeColor(color.cgColor)
            bitmapContext.setFillColor(color.cgColor)
        }
    }

    var penWidth: Number {
        didSet {
            bitmapContext.setLineWidth(penWidth * canvasScale)
        }
    }

    var variablesStack: [[String: Number]]

    var procedures: [String: Procedure]

    var drawingHandler: DrawingHandler?

    // MARK: - Initializer

    init(canvasSize: CGSize, canvasScale: CGFloat = 1, tortoise image: CGImage? = nil) {
        let halfWidth = canvasSize.width * 0.5
        let halfHeight = canvasSize.height * 0.5
        let bitmapSize = canvasSize.applying(CGAffineTransform(scaleX: canvasScale, y: canvasScale))

        self.canvasScale = canvasScale
        self.canvasRect = CGRect(origin: CGPoint(x: -halfWidth, y: -halfHeight), size: canvasSize)
        self.bitmapContext = Context.createBitmapCGContext(size: bitmapSize)
        self.bitmapContext.tg_helloTortoiseGraphicsWorld()

        self.colorPalette = ColorPalette()

        self.tortoiseImage = image

        self.showTortoise = Context.defaultShowTortoise
        self.backgroundColor = Context.defaultBackgroundColor
        self.position = Context.defaultPosition
        self.heading = Context.defaultHeading
        self.penDown = Context.defaultPenDown
        self.penColor = Context.defaultPenColor
        self.penWidth = Context.defaultPenWidth

        self.variablesStack = Context.defaultVariableStack
        self.procedures = Context.defaultProcedures

        self.reset()
    }

    // MARK: - Methods

    func reset() {
        backgroundColor = Context.defaultBackgroundColor
        showTortoise = Context.defaultShowTortoise
        penDown = Context.defaultPenDown
        penColor = Context.defaultPenColor
        penWidth = Context.defaultPenWidth
        drawingHandler = nil

        colorPalette.reset()
        clearScreen()

        variablesStack = Context.defaultVariableStack
        procedures = Context.defaultProcedures
    }

    func clearScreen() {
        clean()

        position = Context.defaultPosition
        heading = Context.defaultHeading
    }

    func clean() {
        bitmapContext.clear(scaledCanvasRect)
        bitmapContext.saveGState()
        bitmapContext.setFillColor(colorPalette.color(number: backgroundColor).cgColor)
        bitmapContext.fill(scaledCanvasRect)
        bitmapContext.restoreGState()
    }

    func render() -> CGImage? {
        bitmapContext.flush()
        guard let image = bitmapContext.makeImage() else { return nil }
        let newCGContext = Context.createBitmapCGContext(size: scaledCanvasRect.size)

        // Draw rendered image
        newCGContext.saveGState()
        newCGContext.tg_moveOriginToCenter()
        newCGContext.draw(image, in: scaledCanvasRect)
        newCGContext.restoreGState()

        // Draw tortoise
        if showTortoise {
            newCGContext.saveGState()
            newCGContext.tg_helloTortoiseGraphicsWorld()
            Context.drawTortoise(newCGContext,
                                 position: position,
                                 heading: heading,
                                 scale: canvasScale,
                                 tortoiseImage: tortoiseImage)
            newCGContext.restoreGState()
        }
        return newCGContext.makeImage()
    }

    // MARK: - Private

    private static func createBitmapCGContext(size: CGSize) -> CGContext {
        return CGContext(data: nil,
                         width: size.width.integer,
                         height: size.height.integer,
                         bitsPerComponent: 8,
                         bytesPerRow: size.width.integer * 4,
                         space: CGColorSpaceCreateDeviceRGB(),
                         bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
        // swiftlint:disable:previous force_unwrapping
    }

    static func drawTortoise(_ cgContext: CGContext, position: CGPoint, heading: Number, scale: CGFloat, tortoiseImage: CGImage?) {
        cgContext.saveGState()
        if let image = tortoiseImage {
            // Draw tortoise image
            let imageSize = CGSize(width: CGFloat(image.width) / scale, height: CGFloat(image.height) / scale)
            let drawRect = CGRect(origin: CGPoint.zero, size: imageSize)
            cgContext.translateBy(x: position.x, y: position.y)
            cgContext.scaleBy(x: scale, y: scale)
            cgContext.rotate(by: (heading-Context.defaultHeading).radian)
            cgContext.translateBy(x: -imageSize.width*0.5, y: -imageSize.height*0.5)
            cgContext.draw(image, in: drawRect)

        } else {
            // Dras triangle's 3 points.
            let transform = CGAffineTransform(translationX: position.x, y: position.y)
                .scaledBy(x: scale, y: scale)
                .rotated(by: heading.radian)
            let pos1 = CGPoint(x:  10, y:  0).applying(transform)
            let pos2 = CGPoint(x: -10, y:  5).applying(transform)
            let pos3 = CGPoint(x: -10, y: -5).applying(transform)

            cgContext.move(to: pos1)
            cgContext.addLine(to: pos2)
            cgContext.addLine(to: pos3)
            cgContext.closePath()
            cgContext.fillPath()
        }
        cgContext.restoreGState()
    }

}
