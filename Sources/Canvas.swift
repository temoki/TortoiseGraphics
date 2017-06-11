#if os(macOS)
import AppKit
public typealias View = NSView
#elseif os(iOS)
import UIKit
public typealias View = UIView
#endif

public class Canvas: View {

    public var animationInterval: TimeInterval = 0.01

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

    public func play(_ block: @escaping (Tortoise) -> Void) {
        tortoise.initialize()

        tortoise.commandedHandler = { [weak self] (tortoise) in
            guard !Thread.isMainThread else { return }
            guard let interval = self?.animationInterval else { return }
            Thread.sleep(forTimeInterval: interval)
        }

        DispatchQueue.global().async { [weak self] in
            guard let tortoise = self?.tortoise else { return }
            block(tortoise)
            tortoise.commandedHandler = nil
        }
    }

    // MARK: - Private

    private let tortoise: Tortoise = Tortoise()

    private var drawingFrameIndex: Int = 0

    private var drawingTimer: Timer?

    private func draw(with context: GraphicsContext) {
        drawingFrameIndex = tortoise.draw(with: context, toFrame: drawingFrameIndex)
        drawingTimer = Timer.scheduledTimer(timeInterval: animationInterval,
                                            target: self,
                                            selector: #selector(self.onAnimaitionTimer(timer:)),
                                            userInfo: nil,
                                            repeats: false)
    }

    @objc private func onAnimaitionTimer(timer: Timer) {
        drawingTimer = nil
        DispatchQueue.main.async { [unowned self] in
            self.updateDisplay()
        }
    }

    private func updateDisplay() {
        #if os(OSX)
            display()
        #elseif os(iOS)
            setNeedsDisplay()
        #endif
    }

}
