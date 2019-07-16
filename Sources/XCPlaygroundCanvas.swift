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
        return UIScreen.main.scale
    }

    public var color: Color {
        didSet {
            imageCanvas?.color = color
        }
    }

    public func drawing(_ block: @escaping (Tortoise) -> Void) {
        drawingQueue.async { [weak self] in
            guard let self = self else { return }
            self.imageCanvas = ImageCanvas(size: self.size,
                                           scale: self.scale,
                                           color: self.color)
            block(Tortoise(pathDrawable: self))
            self.imageCanvas = nil
        }
    }

    // MARK: - Path Drawable

    func strokePath(path: CGPath, color: CGColor, lineWidth: CGFloat) {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let shapeLayer = CAShapeLayer()
            self.layer.addSublayer(shapeLayer)
            shapeLayer.frame = self.bounds

            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
            animation.toValue = path
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.autoreverses = false

            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                self?.imageCanvas?.strokePath(path: path, color: color, lineWidth: lineWidth)
                if let cgImage = self?.imageCanvas?.cgImage {
                    self?.layer.contents = cgImage
                }
                shapeLayer.removeFromSuperlayer()
                semaphore.signal()
            }
            shapeLayer.backgroundColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = color
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.add(animation, forKey: "animation")
            CATransaction.commit()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func fillPath(path: CGPath, color: CGColor) {
    }

    // MARK: - Private

    private var imageCanvas: ImageCanvas?
    private let drawingQueue: DispatchQueue = DispatchQueue(label: "tortoise-graphics-xcplayground-canvas",
                                                            qos: .default)

}
