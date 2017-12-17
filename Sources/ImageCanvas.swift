#if os(macOS)
import AppKit
public typealias Image = NSImage
#elseif os(iOS)
import UIKit
import MobileCoreServices
public typealias Image = UIImage
#endif

public class ImageCanvas {

    private let 🐢: Tortoise
    private let size: CGSize
    private let scale: CGFloat

    init(size: CGSize, scale: CGFloat = 1) {
        self.🐢 = Tortoise()
        self.size = size
        self.scale = scale
    }

    // MARK: - Canvas Protocol

    public func drawing(_ block: @escaping (Tortoise) -> Void) {
        🐢.initialize()
        block(🐢)
    }

    // MARK: - Make Image

    public var cgImage: CGImage? {
        let context = GraphicsContext.createBitmapContext(size: size, scale: scale)
        🐢.draw(with: context, toFrame: nil)
        return context.cgContext.makeImage()
    }

    public var image: Image? {
        guard let cgImage = cgImage else { return nil }
        #if os(macOS)
            return NSImage(cgImage: cgImage, size: size)
        #elseif os(iOS)
            return UIImage(cgImage: cgImage)
        #else
            return nil
        #endif
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

    @discardableResult
    public func writeGIF(to fileURL: URL, frameRate: Int = 30) -> Bool {
        return writeAnimationImage(to: fileURL, type: kUTTypeGIF, frameDelay: 1 / Float64(frameRate))
    }

    private func writeImage(to fileURL: URL, type: CFString) -> Bool {
        guard let cgImage = cgImage else { return false }
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, type, 1, nil) else { return false }
        CGImageDestinationAddImage(destination, cgImage, imageProperties as CFDictionary)
        return CGImageDestinationFinalize(destination)
    }

    private func writeAnimationImage(to fileURL: URL, type: CFString, frameDelay: Float64) -> Bool {
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, type, 🐢.commands.count, nil) else { return false }

        for frameIndex in 0 ..< 🐢.commands.count {
            let context = GraphicsContext.createBitmapContext(size: size, scale: scale)
            🐢.draw(with: context, toFrame: frameIndex)
            guard let cgImage = context.cgContext.makeImage() else { return false }

            let frameProperties: [String: Any] = [
                kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: frameDelay]
            ]
            CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
        }
        return CGImageDestinationFinalize(destination)
    }

    private var imageProperties: [String: Any] {
        let defaultDPI: CGFloat = 72
        return [
            kCGImagePropertyPixelWidth as String: Int(size.width * scale),
            kCGImagePropertyPixelHeight as String: Int(size.height * scale),
            kCGImagePropertyDPIWidth as String: Int(defaultDPI * scale),
            kCGImagePropertyDPIHeight as String: Int(defaultDPI * scale)
        ]
    }

}
