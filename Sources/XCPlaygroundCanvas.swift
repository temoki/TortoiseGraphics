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
        super.init(frame: frame)
        layer.contents = imageCanvas.cgImage
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
    
    func headingChanged(_ state: TortoiseState, from heading: Degree) {
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
        case headingChanged(TortoiseState, Degree)
        case penChanged(TortoiseState, Pen)
        case shapeChanged(TortoiseState, Shape)
        case fillRequested(TortoiseState)
        case backgroundChanged(Color)
    }

    private let lock = NSLock()
    private var eventQueue: [Event] = []
    private var isHandling: Bool = false

    private let imageCanvas: ImageCanvas

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
            completion()
            
        case .positionChanged(let state, let position):
            handlePositionChangedEvent(state: state, from: position, completion: completion)
            
        case .headingChanged(let state, let heading):
            completion()

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
    
    private func handleBackgroundChangedEvent(color: Color, completion: () -> Void) {
        imageCanvas.color = color
        layer.contents = imageCanvas.cgImage
        completion()
    }

    private func handlePositionChangedEvent(state: TortoiseState, from position: CGPoint, completion: @escaping () -> Void) {
        var pathTransform = makeTransform()

        let path = [position, state.position]
        let toPath = path.toCGPath().copy(using: &pathTransform)
        let fromPath = path.first?.toCGPath().copy(using: &pathTransform)

        let shapeLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        shapeLayer.frame = CGRect(origin: .zero, size: self.size)
        shapeLayer.path = fromPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = state.pen.color
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = state.pen.width

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.imageCanvas.positionChanged(state, from: position)
            self?.layer.contents = self?.imageCanvas.cgImage
            shapeLayer.removeFromSuperlayer()
            completion()
        }

        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        animation.toValue = toPath
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.autoreverses = false
        shapeLayer.add(animation, forKey: "stroke-animation")
        CATransaction.commit()
    }

    private func handleFillRequestedEvent(state: TortoiseState, completion: @escaping () -> Void) {
        guard let fillPath = state.fillPath else {
            completion()
            return
        }
        
        var pathTransform = makeTransform()
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
    
    private func makeTransform() -> CGAffineTransform {
        return CGAffineTransform(translationX: size.width * 0.5, y: size.height * 0.5).scaledBy(x: 1, y: -1)
    }

}
