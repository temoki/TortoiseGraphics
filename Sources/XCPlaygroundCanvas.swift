//
//  XCPlaygroundCanvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import AppKit

public class XCPlaygroundCanvas: NSView, Canvas, PathDrawable {

    public init(frame: CGRect, backgroundColor: Color? = nil) {
        self.backgroundColor = backgroundColor ?? Color.white
        super.init(frame: frame)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Canvas

    public var size: CGSize {
        return self.bounds.size
    }

    public var scale: CGFloat {
        return NSScreen.main?.backingScaleFactor ?? 1
    }

    public var backgroundColor: Color {
        didSet {
            imageCanvas?.backgroundColor = backgroundColor
        }
    }

    public func drawing(_ block: @escaping (Tortoise) -> Void) {
        drawingQueue.async { [weak self] in
            guard let self = self else { return }
            self.imageCanvas = ImageCanvas(size: self.size,
                                           scale: self.scale,
                                           backgroundColor: self.backgroundColor)
            block(Tortoise(pathDrawable: self))
            self.imageCanvas = nil
        }
    }

    // MARK: - Path Drawable

    func strokePath(path: CGPath, color: CGColor, lineWidth: CGFloat) {
        guard let imageCanvas = self.imageCanvas else { return }
        imageCanvas.strokePath(path: path, color: color, lineWidth: lineWidth)
        if let cgImage = imageCanvas.cgImage {
            DispatchQueue.main.async { [weak self] in
                self?.layer?.contents = cgImage
            }
        }
    }

    func fillPath(path: CGPath, color: CGColor) {
    }

    // MARK: - Private

    private var imageCanvas: ImageCanvas?
    private let drawingQueue: DispatchQueue = DispatchQueue(label: "tortoise-graphics-xcplayground-canvas",
                                                            qos: .default)

}
