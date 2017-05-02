//
//  CanvasView.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/04/22.
//  Copyright © 2017 temoki. All rights reserved.
//

#if os(OSX)
    import AppKit
    public typealias View = NSView
    public typealias Image = NSImage
#elseif os(iOS)
    import UIKit
    public typealias View = UIView
    public typealias Image = UIImage
#endif

#if os(OSX) || os(iOS)
    fileprivate class DrawingStack {

        private var images: [CGImage] = []

        func set(_ image: CGImage) {
            objc_sync_enter(self)
            images.removeAll(keepingCapacity: false)
            images.append(image)
            objc_sync_exit(self)
        }

        func clear() {
            objc_sync_enter(self)
            images.removeAll(keepingCapacity: false)
            objc_sync_exit(self)
        }

        func push(_ image: CGImage) {
            objc_sync_enter(self)
            images.append(image)
            objc_sync_exit(self)
        }

        func pop() -> CGImage? {
            guard !images.isEmpty else { return nil }
            objc_sync_enter(self)
            let image = images.removeFirst()
            objc_sync_exit(self)
            return image
        }

    }
#endif

#if os(OSX)
    fileprivate extension NSImage {
        var cgImage: CGImage? {
            var rect = CGRect(origin: .zero, size: self.size)
            return cgImage(forProposedRect: &rect, context: nil, hints: nil)
        }
    }
#endif

#if os(OSX) || os(iOS)
    /// Canvas View
    public class CanvasView: View {

        // MARK: - Properties

        /// Canvas
        public let canvas: Canvas

        private var drawingStack = DrawingStack()

        /// Initializer
        /// - parameter canvasSize: Canvas size
        /// - parameter tortoise: Tortoise icon image
        public init(canvasSize: CGSize, tortoise image: Image? = nil) {
            #if os(iOS)
                let scale = UIScreen.main.scale
            #else
                let scale = NSScreen.main()?.backingScaleFactor ?? 1
            #endif
            self.canvas = Canvas(size: canvasSize, scale: scale, tortoise: image?.cgImage)
            super.init(frame: CGRect(origin: .zero, size: canvasSize))
        }

        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Draw

        /// Draw
        public func draw() {
            guard let image = canvas.draw() else { return }
            drawingStack.set(image)
            updateDisplay()
        }

        /// Draw with animation
        /// - parameter atTimeInterval : time interval of animation
        public func animate(atTimeInterval interval: TimeInterval, completion: (() -> Void)? = nil) {
            drawingStack.clear()
            DispatchQueue.global().async { [unowned self] in
                self.canvas.draw(oneByOne: { (image) in
                    Thread.sleep(forTimeInterval: interval)
                    self.drawingStack.push(image)
                    DispatchQueue.main.async {
                        self.updateDisplay()
                    }
                })
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }

        // MARK: - Override

        #if os(OSX)
        public override func draw(_ dirtyRect: NSRect) {
            super.draw(dirtyRect)
            guard let cgContext = NSGraphicsContext.current()?.cgContext else { return }
            draw(with: cgContext)
        }
        #elseif os(iOS)
        public override func draw(_ rect: CGRect) {
            super.draw(rect)
            guard let cgContext = UIGraphicsGetCurrentContext() else { return }
            draw(with: cgContext)
        }
        #endif

        // MARK: - Private

        private func draw(with cgContext: CGContext) {
            guard let image = drawingStack.pop() else { return }
            cgContext.saveGState()
            cgContext.draw(image, in: self.bounds)
            cgContext.restoreGState()

        }

        private func updateDisplay() {
            #if os(OSX)
                display()
            #elseif os(iOS)
                setNeedsDisplay()
            #endif
        }

    }
#endif
