import CoreGraphics

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
import MobileCoreServices
#endif

public extension Tortoise {

    #if os(iOS)
    public func makeImage(of size: CGSize) -> UIImage? {
        guard let cgImage = makeCGImage(of: size) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    #endif

    #if os(macOS)
    public func makeImage(of size: CGSize) -> NSImage? {
        guard let cgImage = makeCGImage(of: size) else { return nil }
        return NSImage(cgImage: cgImage, size: size)
    }

    @discardableResult
    public func writePNG(of size: CGSize, to fileURL: URL) -> Bool {
        return writeImage(size: size, type: kUTTypePNG, fileURL: fileURL as CFURL)
    }

    @discardableResult
    public func writeJPEG(of size: CGSize, to fileURL: URL) -> Bool {
        return writeImage(size: size, type: kUTTypeJPEG, fileURL: fileURL as CFURL)
    }

    @discardableResult
    public func writeGIF(of size: CGSize, to fileURL: URL) -> Bool {
        return writeAnimationImage(size: size, type: kUTTypeGIF, fileURL: fileURL as CFURL)
    }
    #endif

}
