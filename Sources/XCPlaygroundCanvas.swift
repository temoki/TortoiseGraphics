//
//  XCPlaygroundCanvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

#if os (iOS)
import UIKit

public class XCPlaygroundCanvas: UIView, Canvas, TortoiseDelegate {

    public init(size: Vec2D, color: Color? = nil) {
        self.canvasColor = color ?? ColorPalette.white.color
        self.imageCanvas = ImageCanvas(size: size, scale: Double(UIScreen.main.scale), color: self.canvasColor)
        self.shapeLayer = CAShapeLayer()
        self.frameObservation = nil
        super.init(frame: CGRect(origin: .zero, size: size.toCGSize()))

        layer.contents = imageCanvas.cgImage
        layer.addSublayer(shapeLayer)

        self.frameObservation = self.observe(\.frame, options: .new) { [weak self] (_, change) in
            guard let newFrame = change.newValue else { return }
            print(newFrame)
            self?.addEvent(.canvasDidChangeSize(newFrame.size))
        }
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Canvas

    public var canvasSize: Vec2D {
        return imageCanvas.canvasSize
    }

    public func canvasColor(_ palette: ColorPalette) {
        canvasColor = palette.color
        addEvent(.canvasDidChangeBackground(canvasColor))
    }

    public func canvasColor(_ r: Double, _ g: Double, _ b: Double) {
        canvasColor = Color(r, g, b)
        addEvent(.canvasDidChangeBackground(canvasColor))
    }

    public func canvasColor(_ hex: String) {
        canvasColor = Color(hex)
        addEvent(.canvasDidChangeBackground(canvasColor))
    }

    public func canvasColor(_ color: Color) {
        canvasColor = color
        addEvent(.canvasDidChangeBackground(canvasColor))
    }

    public private(set) var canvasColor: Color

    // MARK: - TortoiseDelegate

    func tortoiseDidInitialized(_ state: TortoiseState) {
        addEvent(.tortoiseDidInitialize(state))
    }

    func tortoiseDidChangePosition(_ state: TortoiseState) {
        addEvent(.tortoiseDidChangePosition(state))
    }

    func tortoiseDidChangeHeading(_ state: TortoiseState) {
        addEvent(.tortoiseDidChangeHeading(state))
    }

    func tortoiseDidChangePen(_ state: TortoiseState) {
        addEvent(.tortoiseDidChangePen(state))
    }

    func tortoiseDidChangeShape(_ state: TortoiseState) {
        addEvent(.tortoiseDidChangeShape(state))
    }

    func tortoiseDidRequestToFill(_ state: TortoiseState) {
        addEvent(.tortoiseDidRequestToFill(state))
    }

    func tortoiseDidRequestToClear(_ state: TortoiseState) {
        addEvent(.tortoiseDidRequestToClear(state))
    }

    // MARK: - Private

    private enum Event {
        case tortoiseDidInitialize(TortoiseState)
        case tortoiseDidChangePosition(TortoiseState)
        case tortoiseDidChangeHeading(TortoiseState)
        case tortoiseDidChangePen(TortoiseState)
        case tortoiseDidChangeShape(TortoiseState)
        case tortoiseDidRequestToFill(TortoiseState)
        case tortoiseDidRequestToClear(TortoiseState)
        case canvasDidChangeBackground(Color)
        case canvasDidChangeSize(CGSize)
    }

    private let lock = NSLock()
    private var eventQueue: [Event] = []
    private var isHandling: Bool = false

    private var imageCanvas: ImageCanvas
    private let shapeLayer: CAShapeLayer
    private var frameObservation: NSKeyValueObservation?

    private func addEvent(_ event: Event) {
        lock.lock()
        eventQueue.append(event)
        if isHandling {
            lock.unlock()
        } else {
            isHandling = true
            lock.unlock()
            handleNextEvent()
        }
    }

    private func handleNextEvent() {
        lock.lock()
        let popped = eventQueue.isEmpty ? nil : eventQueue.removeFirst()
        if let popped = popped {
            lock.unlock()
            handleEvent(popped) { [weak self] in
                self?.handleNextEvent()
            }
        } else {
            isHandling = false
            lock.unlock()
        }
    }

    private func handleEvent(_ event: Event, completion: @escaping () -> Void) {
        switch event {
        case .tortoiseDidInitialize(let state):
            handleInitializeEvent(state, completion)
        case .tortoiseDidChangePosition(let state):
            handleChangePositionEvent(state, completion)
        case .tortoiseDidChangeHeading(let state):
            handleChangeHeadingEvent(state, completion)
        case .tortoiseDidChangePen(let state):
            handleChangePenEvent(state, completion)
        case .tortoiseDidChangeShape(let state):
            handleChangeShapeEvent(state, completion)
        case .tortoiseDidRequestToFill(let state):
            handleRequestToFillEvent(state, completion)
        case .tortoiseDidRequestToClear(let state):
            handleRequestToClearEvent(state, completion)
        case .canvasDidChangeBackground(let color):
            handleChangeBackgroundEvent(color, completion)
        case .canvasDidChangeSize(let size):
            handleChangeSizeEvent(size, completion)
        }
    }

    private func handleInitializeEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        CATransaction.transactionWithoutAnimation({
            shapeLayer.position = translatedPosition(position: state.position.toCGPoint())
            shapeLayer.transform = rotatedTransform(angle: state.heading)
            shapeLayer.path = makeShapePath(shape: state.shape,
                                            penSize: CGFloat(state.pen.width))
            shapeLayer.strokeColor = state.pen.color.toCGColor()
            shapeLayer.lineWidth = CGFloat(state.pen.width)
            shapeLayer.fillColor = state.pen.fillColor.toCGColor()
        }, completion: completion)
    }

    private func handleChangePositionEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        let fromPos = shapeLayer.position
        let toPos = translatedPosition(position: state.position.toCGPoint())
        let distance = fromPos.distance(to: toPos)

        let fromPath = fromPos.toCGPath()
        let toPath = [fromPos, toPos].toCGPath()

        let pathLayer: CAShapeLayer? = state.pen.isDown ? CAShapeLayer() : nil

        CATransaction.transaction({
            let animationDuration = state.speed.movementDuration(distance: Double(distance))

            if let pathLayer = pathLayer {
                layer.addSublayer(pathLayer)
                pathLayer.frame = CGRect(origin: .zero, size: self.canvasSize.toCGSize())
                pathLayer.path = fromPath
                pathLayer.backgroundColor = CGColor.clear
                pathLayer.strokeColor = state.pen.color.toCGColor()
                pathLayer.fillColor = CGColor.clear
                pathLayer.lineWidth = CGFloat(state.pen.width)

                let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
                pathAnimation.toValue = toPath
                pathAnimation.duration = animationDuration
                pathLayer.add(pathAnimation, forKey: "shape-path")
            }

            let shapeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CAShapeLayer.position))
            shapeAnimation.path = toPath
            shapeAnimation.duration = animationDuration
            shapeLayer.add(shapeAnimation, forKey: "shape-position)")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidChangePosition(state)
            self?.layer.contents = self?.imageCanvas.cgImage
            pathLayer?.removeFromSuperlayer()

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.position = toPos
            }, completion: completion)
        })
    }

    private func handleChangeHeadingEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        let toTransform = rotatedTransform(angle: state.heading)

        CATransaction.transaction({
            let shapeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
            shapeAnimation.toValue = toTransform
            shapeAnimation.duration = state.speed.animationDuration()
            shapeLayer.add(shapeAnimation, forKey: "shape-transform")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidChangeHeading(state)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.transform = toTransform
            }, completion: completion)
        })
    }

    private func handleChangePenEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        shapeLayer.strokeColor = state.pen.color.toCGColor()
        shapeLayer.lineWidth = CGFloat(state.pen.width)
        shapeLayer.fillColor = state.pen.fillColor.toCGColor()
        handleChangeShapeEvent(state, completion)
    }

    private func handleChangeShapeEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        let toPath = makeShapePath(shape: state.shape,
                                   penSize: CGFloat(state.pen.width))
        let toOpacity: Float = state.shape.isVisible ? 1 : 0

        CATransaction.transaction({
            let animationDuration = state.speed.animationDuration()

            let anim1 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
            anim1.toValue = toPath
            anim1.duration = animationDuration
            shapeLayer.add(anim1, forKey: "shape-path")

            let anim2 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
            anim2.toValue = toOpacity
            anim2.duration = animationDuration
            shapeLayer.add(anim2, forKey: "shape-opacity")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidChangeShape(state)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.path = toPath
                self?.shapeLayer.opacity = toOpacity
            }, completion: completion)
        })
    }

    private func handleRequestToFillEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        guard let fillPath = state.fillPath else {
            completion()
            return
        }

        let fillLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        fillLayer.frame = CGRect(origin: .zero, size: .zero)
        fillLayer.path = translatedPath(path: fillPath.toCGPath())
        fillLayer.backgroundColor = CGColor.clear
        fillLayer.strokeColor = CGColor.clear
        fillLayer.fillColor = CGColor.clear
        fillLayer.fillRule = .evenOdd

        CATransaction.transaction({
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
            animation.toValue = state.pen.fillColor
            animation.duration = state.speed.animationDuration()
            fillLayer.add(animation, forKey: "fill-path")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidRequestToFill(state)
            self?.layer.contents = self?.imageCanvas.cgImage
            fillLayer.removeFromSuperlayer()
            completion()
        })
    }

    private func handleRequestToClearEvent(_ state: TortoiseState, _ completion: @escaping () -> Void) {
        imageCanvas.tortoiseDidRequestToClear(state)
        layer.contents = imageCanvas.cgImage
        completion()
    }

    private func handleChangeBackgroundEvent(_ color: Color, _ completion: () -> Void) {
        imageCanvas.canvasColor(color)
        layer.contents = imageCanvas.cgImage
        completion()
    }

    private func handleChangeSizeEvent(_ size: CGSize, _ completion: () -> Void) {
        defer { completion() }
        let oldSize = imageCanvas.canvasSize.toCGSize()
        guard size != oldSize else { return }
        let newCanvas = ImageCanvas(size: Vec2D(size: size),
                                    scale: Double(UIScreen.main.scale),
                                    color: canvasColor)
        if let oldImage = imageCanvas.cgImage {
            let drawRect = CGRect(x: (size.width - oldSize.width) * 0.5,
                                  y: (size.height - oldSize.height) * 0.5,
                                  width: oldSize.width,
                                  height: oldSize.height)
            newCanvas.drawImage(oldImage, in: drawRect)
        }
        imageCanvas = newCanvas
        layer.contents = imageCanvas.cgImage
    }

    private func makePositionTransform() -> CGAffineTransform {
        return CGAffineTransform(
            translationX: CGFloat(canvasSize.x * 0.5), y: CGFloat(canvasSize.y * 0.5)
            ).scaledBy(x: 1, y: -1)
    }

    private func translatedPosition(position: CGPoint) -> CGPoint {
        return position.applying(makePositionTransform())
    }

    private func translatedPath(path: CGPath) -> CGPath {
        var transform = makePositionTransform()
        return path.copy(using: &transform) ?? path
    }

    private func rotatedTransform(angle: Angle) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle.radian), 0, 0, 1)
    }

    private func makeShapePath(shape: Shape, penSize: CGFloat) -> CGPath {
        let transform = CGAffineTransform(scaleX: 1, y: -1)
        let shapePath = CGMutablePath()
        shapePath.addPath(shape.scaledPath(by: penSize*10), transform: transform)
        shapePath.closeSubpath()
        return shapePath
    }

}
#endif
