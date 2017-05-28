//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/29.
//  Copyright © 2017 temoki. All rights reserved.
//

#if os(OSX)
import AppKit
public typealias View = NSView
#elseif os(iOS)
import UIKit
public typealias View = UIView
#endif

public class Canvas: View {
    
    public let tortoise = Tortoise()
    
    public var 🐢: Tortoise { return self.tortoise }
    
    public var animationInterval: TimeInterval = 1.0 / 30.0 // 30 FPS
    
    public func draw(animated: Bool) {
        drawingFrameIndex = animated ? 0 : nil
        updateDisplay()
    }
    
    // MARK: - Override
    
    #if os(OSX)
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        guard let cgContext = NSGraphicsContext.current()?.cgContext else { return }
        let context = GraphicsContext(size: self.frame.size, cgContext: cgContext, isUIViewContext: false)
        draw(with: context)
    }
    #elseif os(iOS)
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let cgContext = UIGraphicsGetCurrentContext() else { return }
        let context = GraphicsContext(size: self.frame.size, cgContext: cgContext, isUIViewContext: true)
        draw(with: context)
    }
    #endif
    
    // MARK: - Private
    
    private var drawingFrameIndex: Int? = nil
    
    private var drawingTimer: Timer? = nil
    
    private func draw(with context: GraphicsContext) {
        guard let nextIndex = tortoise.run(with: context, toFrame: drawingFrameIndex) else {
            drawingFrameIndex = nil
            drawingTimer = nil
            return
        }
        
        drawingFrameIndex = nextIndex
        drawingTimer = Timer.scheduledTimer(timeInterval: animationInterval,
                                            target: self,
                                            selector: #selector(self.onAnimaitionTimer(timer:)),
                                            userInfo: nil,
                                            repeats: false)
    }
    
    @objc private func onAnimaitionTimer(timer: Timer) {
        drawingTimer = nil
        updateDisplay()
    }
    
    private func updateDisplay() {
        #if os(OSX)
            display()
        #elseif os(iOS)
            setNeedsDisplay()
        #endif
    }
    
}
