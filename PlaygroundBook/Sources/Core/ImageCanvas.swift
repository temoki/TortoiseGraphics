import Foundation
import CoreGraphics

public class ImageCanvas: Canvas, TortoiseDelegate {

    public init(size: Vec2D, scale: Double = 1, color: Color? = nil) {
        self.canvasSize = size
        self.canvasColor = color ?? ColorPalette.white.color
        self.bitmapScale = CGFloat(scale)
        self.bitmapContext = createForegroundContext(size: size.toCGSize(),
                                                     scale: self.bitmapScale)
    }

    public var cgImage: CGImage? {
        let size = canvasSize.toCGSize()
        let bgContext = createBackgroundContext(size: size, scale: bitmapScale)
        bgContext?.setFillColor(canvasColor.cgColor)
        bgContext?.fill(CGRect(origin: .zero, size: size))
        if let fgImage = bitmapContext?.makeImage() {
            bgContext?.draw(fgImage, in: CGRect(origin: .zero, size: size))
        }
        return bgContext?.makeImage()
    }

    // MARK: - Canvas

    public func add(_ tortoise: Tortoise) {
        guard tortoise.delegate !== self else { return }
        tortoise.delegate?.tortoiseDidAddToOtherCanvas(tortoise.uuid, tortoise.state)
        tortoise.delegate = self
        tortoiseDidInitialized(tortoise.uuid, tortoise.state)
    }

    public var canvasSize: Vec2D

    public func canvasColor(_ palette: ColorPalette) {
        canvasColor = palette.color
    }

    public func canvasColor(_ r: Double, _ g: Double, _ b: Double) {
        canvasColor = Color(r, g, b)
    }

    public func canvasColor(_ hex: String) {
        canvasColor = Color(hex)
    }

    public func canvasColor(_ color: Color) {
        canvasColor = color
    }

    public private(set) var canvasColor: Color

    // MARK: - TortoiseDelegate

    func tortoiseDidInitialized(_ uuid: UUID, _ state: TortoiseState) {
        tortoisePositions[uuid] = state.position
    }

    func tortoiseDidChangePosition(_ uuid: UUID, _ state: TortoiseState) {
        let position = tortoisePositions[uuid] ?? .zero
        tortoisePositions[uuid] = state.position
        guard state.pen.isDown else { return }
        bitmapContext?.saveGState()
        bitmapContext?.setStrokeColor(state.pen.color.cgColor)
        bitmapContext?.setFillColor(CGColor.clear)
        bitmapContext?.setLineWidth(CGFloat(state.pen.width))
        bitmapContext?.addPath([position, state.position].toCGPath())
        bitmapContext?.strokePath()
        bitmapContext?.restoreGState()
    }

    func tortoiseDidChangeHeading(_ uuid: UUID, _ state: TortoiseState) {
        // Nothing to do
    }

    func tortoiseDidChangePen(_ uuid: UUID, _ state: TortoiseState) {
        // Nothing to do
    }

    func tortoiseDidChangeShape(_ uuid: UUID, _ state: TortoiseState) {
        // Nothing to do
    }

    func tortoiseDidRequestToFill(_ uuid: UUID, _ state: TortoiseState) {
        guard let fillPath = state.fillPath else { return }
        bitmapContext?.saveGState()
        bitmapContext?.setStrokeColor(CGColor.clear)
        bitmapContext?.setFillColor(state.pen.fillColor.cgColor)
        bitmapContext?.addPath(fillPath.toCGPath())
        bitmapContext?.fillPath(using: .evenOdd)
        bitmapContext?.restoreGState()
    }

    func tortoiseDidRequestToClear(_ uuid: UUID, _ state: TortoiseState) {
        bitmapContext = createForegroundContext(size: canvasSize.toCGSize(),
                                                scale: bitmapScale)
    }

    func tortoiseDidAddToOtherCanvas(_ uuid: UUID, _ state: TortoiseState) {
        tortoisePositions[uuid] = nil
    }

    // MARK: - Internal

    func drawImage(_ image: CGImage, in rect: CGRect) {
        bitmapContext?.draw(image, in: rect)
    }

    // MARK: - Private

    private var bitmapContext: CGContext?

    private let bitmapScale: CGFloat

    private var tortoisePositions: [UUID: Vec2D] = [:]

}

private func createBackgroundContext(size: CGSize, scale: CGFloat) -> CGContext? {
    let width = Int(size.width * scale)
    let height = Int(size.height * scale)
    guard width > 0, height > 0 else { return nil }

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

private func createForegroundContext(size: CGSize, scale: CGFloat) -> CGContext? {
    let context = createBackgroundContext(size: size, scale: scale)
    context?.translateBy(x: size.width * 0.5, y: size.height * 0.5)
    return context
}
