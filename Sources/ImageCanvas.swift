import Foundation
import CoreGraphics

public class ImageCanvas: Canvas, TortoiseDelegate {

    public init(size: CGSize, scale: CGFloat = 1, color: Color? = nil) {
        self.canvasSize = size
        self.canvasColor = color ?? Color.white
        self.bitmapScale = scale
        self.bitmapContext = createBitmapContext(size: size, scale: scale)
        self.bitmapContext.translateBy(x: size.width * 0.5, y: size.height * 0.5)
    }

    public var cgImage: CGImage? {
        let bgContext = createBitmapContext(size: canvasSize, scale: bitmapScale)
        bgContext.setFillColor(canvasColor.cgColor)
        bgContext.fill(CGRect(origin: .zero, size: canvasSize))
        if let fgImage = bitmapContext.makeImage() {
            bgContext.draw(fgImage, in: CGRect(origin: .zero, size: canvasSize))
        }
        return bgContext.makeImage()
    }

    // MARK: - Canvas

    public var canvasSize: CGSize

    public var canvasColor: Color

    // MARK: - TortoiseDelegate

    func tortoiseDidInitialized(_ state: TortoiseState) {
        currentPosition = state.position
    }

    func tortoiseDidChangePosition(_ state: TortoiseState) {
        guard state.pen.isDown else { return }
        bitmapContext.saveGState()
        bitmapContext.setStrokeColor(state.pen.color)
        bitmapContext.setFillColor(CGColor.clear)
        bitmapContext.setLineWidth(state.pen.width)
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

    func tortoiseDidRequestFilling(_ state: TortoiseState) {
        guard let fillPath = state.fillPath else { return }
        bitmapContext.saveGState()
        bitmapContext.setStrokeColor(CGColor.clear)
        bitmapContext.setFillColor(state.pen.fillColor)
        bitmapContext.addPath(fillPath.toCGPath())
        bitmapContext.fillPath()
        bitmapContext.restoreGState()
    }

    // MARK: - Private

    private let bitmapContext: CGContext

    private let bitmapScale: CGFloat

    private var currentPosition: CGPoint = .zero

}

private func createBitmapContext(size: CGSize, scale: CGFloat) -> CGContext {
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
