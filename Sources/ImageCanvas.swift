import Foundation
import CoreGraphics

public class ImageCanvas: Canvas, PathDrawable {

    public init(size: CGSize, scale: CGFloat = 1, backgroundColor: Color? = nil) {
        self.size = size
        self.scale = scale
        self.backgroundColor = backgroundColor ?? Color.white
        self.context = createBitmapContext(size: size, scale: scale)
        self.context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
    }

    public var cgImage: CGImage? {
        let bgContext = createBitmapContext(size: size, scale: scale)
        bgContext.setFillColor(backgroundColor.cgColor)
        bgContext.fill(CGRect(origin: .zero, size: size))
        if let fgImage = context.makeImage() {
            bgContext.draw(fgImage, in: CGRect(origin: .zero, size: size))
        }
        return bgContext.makeImage()
    }

    @discardableResult
    public func writePNG(to fileURL: URL) -> Bool {
        return writeImage(to: fileURL, type: kUTTypePNG)
    }

    @discardableResult
    public func writeJPEG(to fileURL: URL) -> Bool {
        return writeImage(to: fileURL, type: kUTTypePNG)
    }

    @discardableResult
    public func writeTIFF(to fileURL: URL) -> Bool {
        return writeImage(to: fileURL, type: kUTTypeTIFF)
    }

    // MARK: - Canvas

    public let size: CGSize

    public let scale: CGFloat

    public var backgroundColor: Color

    public func drawing(_ block: @escaping (Tortoise) -> Void) {
        block(Tortoise(pathDrawable: self))
    }

    // MARK: - PathDrawable

    func strokePath(path: CGPath, color: CGColor, lineWidth: CGFloat) {
        context.saveGState()
        context.setStrokeColor(color)
        context.setFillColor(CGColor.clear)
        context.setLineWidth(lineWidth)
        context.addPath(path)
        context.strokePath()
        context.restoreGState()
    }

    func fillPath(path: CGPath, color: CGColor) {
        context.saveGState()
        context.setStrokeColor(CGColor.clear)
        context.setFillColor(color)
        context.addPath(path)
        context.fillPath()
        context.restoreGState()
    }

    // MARK: - Private

    private let context: CGContext

    private let defaultDPI: CGFloat = 72

    private func writeImage(to fileURL: URL, type: CFString) -> Bool {
        guard let cgImage = cgImage else { return false }
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, type, 1, nil) else { return false }
        CGImageDestinationAddImage(destination, cgImage, imageProperties as CFDictionary)
        return CGImageDestinationFinalize(destination)
    }

    private var imageProperties: [String: Any] {
        return [
            kCGImagePropertyPixelWidth as String: Int(size.width * scale),
            kCGImagePropertyPixelHeight as String: Int(size.height * scale),
            kCGImagePropertyDPIWidth as String: Int(defaultDPI * scale),
            kCGImagePropertyDPIHeight as String: Int(defaultDPI * scale)
        ]
    }

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
