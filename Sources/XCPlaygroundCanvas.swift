//
//  XCPlaygroundCanvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import UIKit

public class XCPlaygroundCanvas: UIView, Canvas, TortoiseEventListner {

    public init(size: CGSize, color: Color? = nil) {
        self.color = color ?? Color.white
        self.imageCanvas = ImageCanvas(size: size, scale: UIScreen.main.scale, color: self.color)
        self.shapeLayer = CAShapeLayer()
        super.init(frame: CGRect(origin: .zero, size: size))
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

    func positionChanged(_ state: TortoiseState) {
        addEvent(.positionChanged(state))
    }

    func headingChanged(_ state: TortoiseState) {
        addEvent(.headingChanged(state))
    }

    func penChanged(_ state: TortoiseState) {
        addEvent(.penChanged(state))
    }

    func shapeChanged(_ state: TortoiseState) {
        addEvent(.shapeChanged(state))
    }

    func fillRequested(_ state: TortoiseState) {
        addEvent(.fillRequested(state))
    }

    private enum Event {
        case initialized(TortoiseState)
        case positionChanged(TortoiseState)
        case headingChanged(TortoiseState)
        case penChanged(TortoiseState)
        case shapeChanged(TortoiseState)
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
        case .positionChanged(let state):
            handlePositionChangedEvent(state: state, completion: completion)
        case .headingChanged(let state):
            handleHeadingChangedEvent(state: state, completion: completion)
        case .penChanged(let state):
            handlePenChangedEvent(state: state, completion: completion)
        case .shapeChanged(let state):
            handleShapeChangedEvent(state: state, completion: completion)
        case .fillRequested(let state):
            handleFillRequestedEvent(state: state, completion: completion)
        case .backgroundChanged(let color):
            handleBackgroundChangedEvent(color: color, completion: completion)
        }
    }

    private func handleInitializedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        CATransaction.transactionWithoutAnimation({
            shapeLayer.position = translatedPosition(position: state.position)
            shapeLayer.transform = rotatedTransform(angle: state.heading)
            shapeLayer.path = makeShapePath(shape: state.shape, penSize: state.pen.width)
            shapeLayer.strokeColor = state.pen.color
            shapeLayer.lineWidth = state.pen.width
            shapeLayer.fillColor = state.pen.fillColor
        }, completion: completion)
    }

    private func handlePositionChangedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        let fromPos = shapeLayer.position
        let toPos = translatedPosition(position: state.position)
        let distance = fromPos.distance(to: toPos)

        let fromPath = fromPos.toCGPath()
        let toPath = [fromPos, toPos].toCGPath()

        let pathLayer: CAShapeLayer? = state.pen.isDown ? CAShapeLayer() : nil

        CATransaction.transaction({
            let animationDuration = state.speed.movementDuration(distance: distance)
            print(animationDuration)

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
            self?.imageCanvas.positionChanged(state)
            self?.layer.contents = self?.imageCanvas.cgImage
            pathLayer?.removeFromSuperlayer()

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.position = toPos
            }, completion: completion)
        })
    }

    private func handleHeadingChangedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        let toTransform = rotatedTransform(angle: state.heading)

        CATransaction.transaction({
            let shapeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
            shapeAnimation.toValue = toTransform
            shapeAnimation.duration = state.speed.animationDuration()
            shapeLayer.add(shapeAnimation, forKey: "shape-transform")

        }, completion: { [weak self] in
            self?.imageCanvas.headingChanged(state)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                self?.shapeLayer.transform = toTransform
            }, completion: completion)
        })
    }

    private func handlePenChangedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        shapeLayer.strokeColor = state.pen.color
        shapeLayer.lineWidth = state.pen.width
        shapeLayer.fillColor = state.pen.fillColor
        handleShapeChangedEvent(state: state, completion: completion)
    }

    private func handleShapeChangedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        let toPath = makeShapePath(shape: state.shape, penSize: state.pen.width)
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
            self?.imageCanvas.shapeChanged(state)
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

        let fillLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        fillLayer.frame = CGRect(origin: .zero, size: .zero)
        fillLayer.path = translatedPath(path: fillPath.toCGPath())
        fillLayer.backgroundColor = UIColor.clear.cgColor
        fillLayer.strokeColor = UIColor.clear.cgColor
        fillLayer.fillColor = UIColor.clear.cgColor

        CATransaction.transaction({
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
            animation.toValue = state.pen.fillColor
            animation.duration = state.speed.animationDuration()
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

    private func translatedPosition(position: CGPoint) -> CGPoint {
        return position.applying(makePositionTransform())
    }

    private func translatedPath(path: CGPath) -> CGPath {
        var transform = makePositionTransform()
        return path.copy(using: &transform) ?? path
    }

    private func rotatedTransform(angle: Angle) -> CATransform3D {
        return CATransform3DMakeRotation(angle.radian, 0, 0, 1)
    }

    private func makeShapePath(shape: Shape, penSize: CGFloat) -> CGPath {
        let transform = CGAffineTransform(scaleX: 1, y: -1)
        let shapePath = CGMutablePath()
        shapePath.addPath(shape.scaledPath(by: penSize*10), transform: transform)
        shapePath.closeSubpath()
        return shapePath
    }

}
