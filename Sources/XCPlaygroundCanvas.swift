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
        shapeLayer.position = CGPoint.zero.applying(makePathTransform())
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
        print(#function)
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
        print(#function)
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
            completion()

        case .shapeChanged(let state, let shape):
            completion()

        case .fillRequested(let state):
            handleFillRequestedEvent(state: state, completion: completion)

        case .backgroundChanged(let color):
            handleBackgroundChangedEvent(color: color, completion: completion)
        }
    }

    private func handleInitializedEvent(state: TortoiseState, completion: () -> Void) {
        let shapeSize = state.pen.width * 10
        let shapePath = CGMutablePath()
        shapePath.addPath(state.shape.scaledPath(by: shapeSize), transform: makeShapeTransform())
        shapePath.closeSubpath()
        shapeLayer.position = state.position.applying(makePathTransform())
        shapeLayer.path = shapePath
        shapeLayer.strokeColor = state.pen.color
        shapeLayer.lineWidth = state.pen.width
        shapeLayer.fillColor = state.pen.fillColor
        shapeLayer.backgroundColor = UIColor.red.cgColor
        completion()
    }

    private func handlePositionChangedEvent(state: TortoiseState, from position: CGPoint, completion: @escaping () -> Void) {
        let pathTransform = makePathTransform()

        let fromPos = position.applying(pathTransform)
        let toPos = state.position.applying(pathTransform)

        let fromPath = fromPos.toCGPath()
        let toPath = [fromPos, toPos].toCGPath()

        let pathLayer: CAShapeLayer? = state.pen.isDown ? CAShapeLayer() : nil

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.imageCanvas.positionChanged(state, from: position)
            self?.layer.contents = self?.imageCanvas.cgImage
            pathLayer?.removeFromSuperlayer()
            completion()
        }

        let animationDuration = CFTimeInterval(1)
        let animationTimingF = CAMediaTimingFunction(name: .linear)

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
            pathAnimation.timingFunction = animationTimingF
            pathAnimation.autoreverses = false
            pathLayer.add(pathAnimation, forKey: "path-animation")
        }

        let shapeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CAShapeLayer.position))
        shapeAnimation.path = toPath
        shapeAnimation.duration = animationDuration
        shapeAnimation.timingFunction = animationTimingF
        shapeAnimation.autoreverses = false
        shapeLayer.add(shapeAnimation, forKey: "shape-animation")

        CATransaction.commit()
    }

    private func handleHeadingChangedEvent(state: TortoiseState, from heading: Angle, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.imageCanvas.headingChanged(state, from: heading)
            self?.layer.contents = self?.imageCanvas.cgImage
            completion()
        }

//        let animationDuration = CFTimeInterval(1)
//        let animationTimingF = CAMediaTimingFunction(name: .linear)
//
//        let fromTransform = shapeLayer.transform
//        var toTransform = CATransform3D()
//        toTransform = CATransform3DTranslate(fromTransform, state.position.x, state.position.y, 0.0)
//        toTransform = CATransform3DRotate(fromTransform, -state.heading.radian, 0.0, 0.0, 1.0)
//        toTransform = CATransform3DTranslate(fromTransform, -state.position.x, state.position.y, 0.0)
//
//        let shapeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
//        shapeAnimation.toValue = toTransform
//        shapeAnimation.duration = animationDuration
//        shapeAnimation.timingFunction = animationTimingF
//        shapeAnimation.autoreverses = false
//        shapeLayer.add(shapeAnimation, forKey: "shape-animation")

        CATransaction.commit()
    }

    private func handleFillRequestedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        guard let fillPath = state.fillPath else {
            completion()
            return
        }

        var pathTransform = makePathTransform()
        let cgPath = fillPath.toCGPath().copy(using: &pathTransform)

        let shapeLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        shapeLayer.frame = CGRect(origin: .zero, size: self.size)
        shapeLayer.path = cgPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.imageCanvas.fillRequested(state)
            self?.layer.contents = self?.imageCanvas.cgImage
            shapeLayer.removeFromSuperlayer()
            completion()
        }

        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        animation.toValue = state.pen.fillColor
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.autoreverses = false
        shapeLayer.add(animation, forKey: "fill-animation")
        CATransaction.commit()
    }

    private func handleBackgroundChangedEvent(color: Color, completion: () -> Void) {
        imageCanvas.color = color
        layer.contents = imageCanvas.cgImage
        completion()
    }

    private func makePathTransform() -> CGAffineTransform {
        return CGAffineTransform(translationX: size.width * 0.5, y: size.height * 0.5).scaledBy(x: 1, y: -1)
    }

    private func makeShapeTransform() -> CGAffineTransform {
        return CGAffineTransform(scaleX: 1, y: -1)
    }

}
