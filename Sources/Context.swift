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

    let bitmapContext: CGContext

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
            bitmapContext.setLineWidth(penWidth)
        }
    }

    var variablesStack: [[String: Number]]

    var procedures: [String: Procedure]

    var drawingHandler: DrawingHandler?

    // MARK: - Initializer

    init(canvasSize: CGSize, tortoise image: CGImage? = nil) {
        let halfWidth = canvasSize.width * 0.5
        let halfHeight = canvasSize.height * 0.5
        self.canvasRect = CGRect(origin: CGPoint(x: -halfWidth, y: -halfHeight), size: canvasSize)
        self.bitmapContext = Context.createBitmapCGContext(canvasSize: canvasSize)
        self.bitmapContext.tg_moveOriginToCenter()
        self.bitmapContext.tg_convertCoordinateSystem()

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
        bitmapContext.clear(canvasRect)
        bitmapContext.saveGState()
        bitmapContext.setFillColor(colorPalette.color(number: backgroundColor).cgColor)
        bitmapContext.fill(canvasRect)
        bitmapContext.restoreGState()
    }

    func render() -> CGImage? {
        bitmapContext.flush()
        guard let image = bitmapContext.makeImage() else { return nil }
        let newCGContext = Context.createBitmapCGContext(canvasSize: canvasRect.size)
        newCGContext.tg_moveOriginToCenter()
        newCGContext.draw(image, in: canvasRect)
        if showTortoise {
            Context.drawTortoise(newCGContext,
                                 position: position,
                                 heading: heading,
                                 tortoiseImage: tortoiseImage)
        }
        return newCGContext.makeImage()
    }

    func drawTortoise() {
        guard showTortoise else { return }
        Context.drawTortoise(bitmapContext,
                             position: position,
                             heading: heading,
                             tortoiseImage: tortoiseImage)
    }

    // MARK: - Private

    private static func createBitmapCGContext(canvasSize: CGSize) -> CGContext {
        return CGContext(data: nil,
                         width: canvasSize.width.integer,
                         height: canvasSize.height.integer,
                         bitsPerComponent: 8,
                         bytesPerRow: canvasSize.width.integer * 4,
                         space: CGColorSpaceCreateDeviceRGB(),
                         bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
        // swiftlint:disable:previous force_unwrapping
    }

    static func drawTortoise(_ cgContext: CGContext, position: CGPoint, heading: Number, tortoiseImage: CGImage?) {
        cgContext.saveGState()
        if let image = tortoiseImage {
            // Draw tortoise image
            let imageSize = CGSize(width: image.width, height: image.height)
            let drawRect = CGRect(origin: CGPoint.zero, size: imageSize)
            cgContext.translateBy(x: position.x, y: position.y)
            cgContext.rotate(by: (heading-Context.defaultHeading).radian)
            cgContext.translateBy(x: -imageSize.width*0.5, y: -imageSize.height*0.5)
            cgContext.draw(image, in: drawRect)

        } else {
            // Dras triangle's 3 points.
            let transform = CGAffineTransform(translationX: position.x, y: position.y)
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
