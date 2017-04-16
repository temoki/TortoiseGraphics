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

    // MARK: - Initializer

    init(canvasSize: CGSize, tortoiseImage: CGImage? = nil) {
        let halfWidth = canvasSize.width * 0.5
        let halfHeight = canvasSize.height * 0.5
        self.canvasRect = CGRect(origin: CGPoint(x: -halfWidth, y: -halfHeight), size: canvasSize)

        self.bitmapContext = CGContext(data: nil,
                                       width: canvasSize.width.integer,
                                       height: canvasSize.height.integer,
                                       bitsPerComponent: 8,
                                       bytesPerRow: canvasSize.width.integer * 4,
                                       space: CGColorSpaceCreateDeviceRGB(),
                                       bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
        // swiftlint:disable:previous force_unwrapping

        // Convert bitmap origin
        self.bitmapContext.translateBy(x: 0, y: canvasSize.height)
        self.bitmapContext.scaleBy(x: 1, y: -1)
        self.bitmapContext.translateBy(x: halfWidth, y: halfHeight)

        self.colorPalette = ColorPalette()

        self.tortoiseImage = tortoiseImage

        self.showTortoise = Context.defaultShowTortoise
        self.backgroundColor = Context.defaultBackgroundColor
        self.position = Context.defaultPosition
        self.heading = Context.defaultHeading
        self.penDown = Context.defaultPenDown
        self.penColor = Context.defaultPenColor
        self.penWidth = Context.defaultPenWidth

        self.variablesStack = Context.defaultVariableStack
        self.procedures = Context.defaultProcedures
    }

    // MARK: - Methods

    func reset() {
        colorPalette.reset()
        clearScreen()

        variablesStack = Context.defaultVariableStack
        procedures = Context.defaultProcedures
    }

    func clearScreen() {
        backgroundColor = Context.defaultBackgroundColor
        clean()

        showTortoise = Context.defaultShowTortoise
        position = Context.defaultPosition
        heading = Context.defaultHeading
        penDown = Context.defaultPenDown
        penColor = Context.defaultPenColor
        penWidth = Context.defaultPenWidth
    }

    func clean() {
        bitmapContext.clear(canvasRect)
        bitmapContext.saveGState()
        bitmapContext.setFillColor(colorPalette.color(number: backgroundColor).cgColor)
        bitmapContext.fill(canvasRect)
        bitmapContext.restoreGState()
    }

    func makeRenderedImage() -> CGImage? {
        bitmapContext.flush()
        return bitmapContext.makeImage()
    }

    func drawTortoise() {
        guard showTortoise else { return }
        bitmapContext.saveGState()
        if let image = tortoiseImage {
            // Draw tortoise image
            let imageSize = CGSize(width: image.width, height: image.height)
            let drawRect = CGRect(origin: CGPoint.zero, size: imageSize)
            bitmapContext.translateBy(x: position.x, y: position.y)
            bitmapContext.rotate(by: (heading-Context.defaultHeading).radian)
            bitmapContext.translateBy(x: -imageSize.width*0.5, y: -imageSize.height*0.5)
            bitmapContext.draw(image, in: drawRect)

        } else {
            // Dras triangle's 3 points.
            let transform = CGAffineTransform(translationX: position.x, y: position.y)
                .rotated(by: heading.radian)
            let pos1 = CGPoint(x:  10, y:  0).applying(transform)
            let pos2 = CGPoint(x: -10, y:  5).applying(transform)
            let pos3 = CGPoint(x: -10, y: -5).applying(transform)

            bitmapContext.move(to: pos1)
            bitmapContext.addLine(to: pos2)
            bitmapContext.addLine(to: pos3)
            bitmapContext.closePath()
            bitmapContext.fillPath()
        }
        bitmapContext.restoreGState()
    }

}
