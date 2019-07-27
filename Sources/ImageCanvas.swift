import Foundation
import CoreGraphics

public class ImageCanvas: Canvas, TortoiseDelegate {

    public init(size: Vec2D, scale: Double = 1, color: RGB? = nil) {
        self.canvasSize = size
        self.canvasColor = color ?? ColorPalette.white.rgb
        self.bitmapScale = CGFloat(scale)
        self.bitmapContext = createForegroundContext(size: size.toCGSize(),
                                                     scale: self.bitmapScale)
    }

    public var cgImage: CGImage? {
        let size = canvasSize.toCGSize()
        let bgContext = createBackgroundContext(size: size, scale: bitmapScale)
        bgContext.setFillColor(canvasColor.cgColor)
        bgContext.fill(CGRect(origin: .zero, size: size))
        if let fgImage = bitmapContext.makeImage() {
            bgContext.draw(fgImage, in: CGRect(origin: .zero, size: size))
        }
        return bgContext.makeImage()
    }

    // MARK: - Canvas

    public var canvasSize: Vec2D

    public func canvasColor(_ palette: ColorPalette) {
        canvasColor = palette.rgb
    }

    public func canvasColor(_ r: Double, _ g: Double, _ b: Double) {
        canvasColor = RGB(r, g, b)
    }

    public func canvasColor(_ hex: String) {
        canvasColor = RGB(hex)
    }

    public func canvasColor(_ rgb: RGB) {
        canvasColor = rgb
    }

    public private(set) var canvasColor: RGB

    // MARK: - TortoiseDelegate

    func tortoiseDidInitialized(_ state: TortoiseState) {
        currentPosition = state.position
    }

    func tortoiseDidChangePosition(_ state: TortoiseState) {
        guard state.pen.isDown else { return }
        bitmapContext.saveGState()
        bitmapContext.setStrokeColor(state.pen.color.cgColor)
        bitmapContext.setFillColor(CGColor.clear)
        bitmapContext.setLineWidth(CGFloat(state.pen.width))
        bitmapContext.addPath([currentPosition, state.position].toCGPath())
        currentPosition = state.position
        bitmapContext.strokePath()
        bitmapContext.restoreGState()
    }

    func tortoiseDidChangeHeading(_ state: TortoiseState) {
        // Nothing to do
    }

    func tortoiseDidChangePen(_ state: TortoiseState) {
        // Nothing to do
    }

    func tortoiseDidChangeShape(_ state: TortoiseState) {
        // Nothing to do
    }

    func tortoiseDidRequestToFill(_ state: TortoiseState) {
        guard let fillPath = state.fillPath else { return }
        bitmapContext.saveGState()
        bitmapContext.setStrokeColor(CGColor.clear)
        bitmapContext.setFillColor(state.pen.fillColor.cgColor)
        bitmapContext.addPath(fillPath.toCGPath())
        bitmapContext.fillPath()
        bitmapContext.restoreGState()
    }

    func tortoiseDidRequestToClear(_ state: TortoiseState) {
        bitmapContext = createForegroundContext(size: canvasSize.toCGSize(),
                                                scale: bitmapScale)
    }

    // MARK: - Internal

    func drawImage(_ image: CGImage, in rect: CGRect) {
        bitmapContext.draw(image, in: rect)
    }

    // MARK: - Private

    private var bitmapContext: CGContext

    private let bitmapScale: CGFloat

    private var currentPosition: Vec2D = Vec2D()

}

private func createBackgroundContext(size: CGSize, scale: CGFloat) -> CGContext {
    let width = Int(size.width * scale)
    let height = Int(size.height * scale)
    let context = CGContext(data: nil,
                            width: width,
                            height: height,
                            bitsPerComponent: 8,
                            bytesPerRow: width * 4,
                            space: CGColorSpaceCreateDeviceRGB(),
                            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
    // swiftlint:disable:previous force_unwrapping
    context.scaleBy(x: scale, y: scale)
    return context
}

private func createForegroundContext(size: CGSize, scale: CGFloat) -> CGContext {
    let context = createBackgroundContext(size: size, scale: scale)
    context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
    return context
}
