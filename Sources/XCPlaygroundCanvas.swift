//
//  XCPlaygroundCanvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import UIKit

public class XCPlaygroundCanvas: UIView, Canvas, TortoiseDelegate {

    public init(frame: CGRect, color: Color? = nil) {
        self.color = color ?? Color.white
        self.imageCanvas = ImageCanvas(size: frame.size, scale: UIScreen.main.scale, color: self.color)
        self.shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        layer.contents = imageCanvas.cgImage
        layer.addSublayer(shapeLayer)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Canvas

    public var size: CGSize {
        return imageCanvas.size
    }

    public var scale: CGFloat {
        return imageCanvas.scale
    }

    public var color: Color {
        didSet {
            addEvent(.backgroundChanged(color))
        }
    }

    // MARK: - TortoiseDelegate

    func initialized(_ state: TortoiseState) {
        addEvent(.initialized(state))
    }

    func positionChanged(_ state: TortoiseState, from position: CGPoint) {
        addEvent(.positionChanged(state, position))
    }

    func headingChanged(_ state: TortoiseState, from heading: Angle) {
        addEvent(.headingChanged(state, heading))
    }

    func penChanged(_ state: TortoiseState, from pen: Pen) {
        addEvent(.penChanged(state, pen))
    }

    func shapeChanged(_ state: TortoiseState, from shape: Shape) {
        addEvent(.shapeChanged(state, shape))
    }

    func fillRequested(_ state: TortoiseState) {
        addEvent(.fillRequested(state))
    }

    private enum Event {
        case initialized(TortoiseState)
        case positionChanged(TortoiseState, CGPoint)
        case headingChanged(TortoiseState, Angle)
        case penChanged(TortoiseState, Pen)
        case shapeChanged(TortoiseState, Shape)
        case fillRequested(TortoiseState)
        case backgroundChanged(Color)
    }

    private let lock = NSLock()
    private var eventQueue: [Event] = []
    private var isHandling: Bool = false

    private let imageCanvas: ImageCanvas
    private let shapeLayer: CAShapeLayer

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
        case .initialized(let state):
            handleInitializedEvent(state: state, completion: completion)

        case .positionChanged(let state, let position):
            handlePositionChangedEvent(state: state, from: position, completion: completion)

        case .headingChanged(let state, let heading):
            handleHeadingChangedEvent(state: state, from: heading, completion: completion)

        case .penChanged(let state, let pen):
            handlePenChangedEvent(state: state, from: pen, completion: completion)

        case .shapeChanged(let state, let shape):
            handleShapeChangedEvent(state: state, from: shape, completion: completion)

        case .fillRequested(let state):
            handleFillRequestedEvent(state: state, completion: completion)

        case .backgroundChanged(let color):
            handleBackgroundChangedEvent(color: color, completion: completion)
        }
    }

    private func handleInitializedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        CATransaction.transactionWithoutAnimation({
            shapeLayer.position = state.position.applying(makePositionTransform())
            shapeLayer.transform = rotatedTransform(state)
            shapeLayer.path = shapePath(state)
            shapeLayer.strokeColor = state.pen.color
            shapeLayer.lineWidth = state.pen.width
            shapeLayer.fillColor = state.pen.fillColor
        }, completion: completion)
    }

    private func handlePositionChangedEvent(state: TortoiseState, from position: CGPoint, completion: @escaping () -> Void) {
        let posTransform = makePositionTransform()
        let fromPos = position.applying(posTransform)
        let toPos = state.position.applying(posTransform)
        let fromPath = fromPos.toCGPath()
        let toPath = [fromPos, toPos].toCGPath()
        let pathLayer: CAShapeLayer? = state.pen.isDown ? CAShapeLayer() : nil

        CATransaction.transaction({
            let animationDuration = CFTimeInterval(1)

            if let pathLayer = pathLayer {
                layer.addSublayer(pathLayer)
                pathLayer.frame = CGRect(origin: .zero, size: self.size)
                pathLayer.path = fromPath
                pathLayer.backgroundColor = UIColor.clear.cgColor
                pathLayer.strokeColor = state.pen.color
                pathLayer.fillColor = UIColor.clear.cgColor
                pathLayer.lineWidth = state.pen.width

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
            self?.imageCanvas.positionChanged(state, from: position)
            self?.layer.contents = self?.imageCanvas.cgImage
            pathLayer?.removeFromSuperlayer()

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.position = toPos
            }, completion: completion)
        })
    }

    private func handleHeadingChangedEvent(state: TortoiseState, from heading: Angle, completion: @escaping () -> Void) {
        let toTransform = rotatedTransform(state)

        CATransaction.transaction({
            let shapeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
            shapeAnimation.toValue = toTransform
            shapeAnimation.duration = 0.2
            shapeLayer.add(shapeAnimation, forKey: "shape-transform")

        }, completion: { [weak self] in
            self?.imageCanvas.headingChanged(state, from: heading)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.transform = toTransform
            }, completion: completion)
        })
    }

    private func handlePenChangedEvent(state: TortoiseState, from pen: Pen, completion: @escaping () -> Void) {
        shapeLayer.strokeColor = state.pen.color
        shapeLayer.lineWidth = state.pen.width
        shapeLayer.fillColor = state.pen.fillColor
        completion()
    }

    private func handleShapeChangedEvent(state: TortoiseState, from shape: Shape, completion: @escaping () -> Void) {
        let toPath = shapePath(state)
        let toOpacity: Float = state.shape.isVisible ? 1 : 0

        CATransaction.transaction({
            let animationDuration = CFTimeInterval(0.2)

            let anim1 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
            anim1.toValue = toPath
            anim1.duration = animationDuration
            shapeLayer.add(anim1, forKey: "shape-path")

            let anim2 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
            anim2.toValue = toOpacity
            anim2.duration = animationDuration
            shapeLayer.add(anim2, forKey: "shape-opacity")

        }, completion: { [weak self] in
            self?.imageCanvas.shapeChanged(state, from: shape)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.path = toPath
                self?.shapeLayer.opacity = toOpacity
            }, completion: completion)
        })
    }

    private func handleFillRequestedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        guard let fillPath = state.fillPath else {
            completion()
            return
        }

        var posTransform = makePositionTransform()
        let cgPath = fillPath.toCGPath().copy(using: &posTransform)

        let fillLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        fillLayer.frame = CGRect(origin: .zero, size: .zero)
        fillLayer.path = cgPath
        fillLayer.backgroundColor = UIColor.clear.cgColor
        fillLayer.strokeColor = UIColor.clear.cgColor
        fillLayer.fillColor = UIColor.clear.cgColor

        CATransaction.transaction({
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
            animation.toValue = state.pen.fillColor
            animation.duration = 0.2
            fillLayer.add(animation, forKey: "fill-path")

        }, completion: { [weak self] in
            self?.imageCanvas.fillRequested(state)
            self?.layer.contents = self?.imageCanvas.cgImage
            fillLayer.removeFromSuperlayer()
            completion()
        })
    }

    private func handleBackgroundChangedEvent(color: Color, completion: () -> Void) {
        imageCanvas.color = color
        layer.contents = imageCanvas.cgImage
        completion()
    }

    private func makePositionTransform() -> CGAffineTransform {
        return CGAffineTransform(translationX: size.width * 0.5, y: size.height * 0.5).scaledBy(x: 1, y: -1)
    }

    private func makeShapeTransform() -> CGAffineTransform {
        return CGAffineTransform(scaleX: 1, y: -1)
    }

    private func rotatedTransform(_ state: TortoiseState) -> CATransform3D {
        return CATransform3DMakeRotation(state.heading.radian, 0, 0, 1)
    }

    private func shapePath(_ state: TortoiseState) -> CGPath {
        let size = state.pen.width * 10
        let path = CGMutablePath()
        path.addPath(state.shape.scaledPath(by: size), transform: makeShapeTransform())
        path.closeSubpath()
        return path
    }

}
