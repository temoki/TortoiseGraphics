//
//  XCPlaygroundCanvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import UIKit

public class XCPlaygroundCanvas: UIView, Canvas, PathDrawable {

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
            addCommand(.background(color: color))
        }
    }

    // MARK: - Path Drawable

    func strokePath(path: [CGPoint], color: CGColor, lineWidth: CGFloat) {
        addCommand(.stroke(path: path, color: color, lineWidth: lineWidth))
    }

    func fillPath(path: [CGPoint], color: CGColor) {
        addCommand(.fill(path: path, color: color))
    }

    private enum DrawCommand {
        case stroke(path: [CGPoint], color: CGColor, lineWidth: CGFloat)
        case fill(path: [CGPoint], color: CGColor)
        case background(color: Color)
    }

    private let lock = NSLock()
    private var commandQueue: [DrawCommand] = []
    private var isDrawing: Bool = false

    private let imageCanvas: ImageCanvas

    private func addCommand(_ command: DrawCommand) {
        print(#function)
        lock.lock()
        commandQueue.append(command)
        if isDrawing {
            lock.unlock()
        } else {
            isDrawing = true
            lock.unlock()
            doNextCommand()
        }
    }

    private func doNextCommand() {
        print(#function)
        lock.lock()
        let popped = commandQueue.isEmpty ? nil : commandQueue.removeFirst()
        if let popped = popped {
            lock.unlock()
            doCommand(popped) { [weak self] in
                self?.doNextCommand()
            }
        } else {
            isDrawing = false
            lock.unlock()
        }
    }

    private func doCommand(_ command: DrawCommand, completion: @escaping () -> Void) {
        switch command {
        case .stroke(let path, let color, let lineWidth):
            strokePath(path: path, color: color, lineWidth: lineWidth, completion: completion)
        case .fill(let path, let color):
            fillPath(path: path, color: color, completion: completion)
        case .background(let color):
            imageCanvas.color = color
            layer.contents = imageCanvas.cgImage
            completion()
        }
    }

    private func strokePath(path: [CGPoint], color: CGColor, lineWidth: CGFloat, completion: @escaping () -> Void) {
        var pathTransform = CGAffineTransform(translationX: size.width * 0.5, y: size.height * 0.5).scaledBy(x: 1, y: -1)
        let toPath = path.toCGPath().copy(using: &pathTransform)
        let fromPath = path.first?.toCGPath().copy(using: &pathTransform)

        let shapeLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        shapeLayer.frame = CGRect(origin: .zero, size: self.size)
        shapeLayer.path = fromPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.imageCanvas.strokePath(path: path, color: color, lineWidth: lineWidth)
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

    private func fillPath(path: [CGPoint], color: CGColor, completion: @escaping () -> Void) {
        var pathTransform = CGAffineTransform(translationX: size.width * 0.5, y: size.height * 0.5).scaledBy(x: 1, y: -1)
        let cgPath = path.toCGPath().copy(using: &pathTransform)

        let shapeLayer = CAShapeLayer()
        self.layer.addSublayer(shapeLayer)
        shapeLayer.frame = CGRect(origin: .zero, size: self.size)
        shapeLayer.path = cgPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.imageCanvas.fillPath(path: path, color: color)
            self?.layer.contents = self?.imageCanvas.cgImage
            shapeLayer.removeFromSuperlayer()
            completion()
        }

        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        animation.toValue = color
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.autoreverses = false
        shapeLayer.add(animation, forKey: "fill-animation")
        CATransaction.commit()
    }

}
