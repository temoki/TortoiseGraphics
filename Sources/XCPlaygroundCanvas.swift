#if os (iOS)
import UIKit

public class XCPlaygroundCanvas: UIView, Canvas, TortoiseDelegate {

    public init(size: Vec2D, color: Color? = nil) {
        self.canvasColor = color ?? ColorPalette.white.color
        self.imageCanvas = ImageCanvas(size: size, scale: Double(UIScreen.main.scale), color: self.canvasColor)
        self.frameObservation = nil
        super.init(frame: CGRect(origin: .zero, size: size.toCGSize()))

        self.frameObservation = self.observe(\.frame, options: .new) { [weak self] (_, change) in
            guard let newFrame = change.newValue else { return }
            self?.addEvent(.canvasDidChangeSize(newFrame.size))
        }
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Canvas

    public func add(_ tortoise: Tortoise) {
        guard tortoise.delegate !== self else { return }
        tortoise.delegate?.tortoiseDidAddToOtherCanvas(tortoise.uuid, tortoise.state)
        tortoise.delegate = self
        tortoiseDidInitialized(tortoise.uuid, tortoise.state)
    }

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

    func tortoiseDidInitialized(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidInitialize(uuid, state))
    }

    func tortoiseDidChangePosition(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidChangePosition(uuid, state))
    }

    func tortoiseDidChangeHeading(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidChangeHeading(uuid, state))
    }

    func tortoiseDidChangePen(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidChangePen(uuid, state))
    }

    func tortoiseDidChangeShape(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidChangeShape(uuid, state))
    }

    func tortoiseDidRequestToFill(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidRequestToFill(uuid, state))
    }

    func tortoiseDidRequestToClear(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidRequestToClear(uuid, state))
    }

    func tortoiseDidAddToOtherCanvas(_ uuid: UUID, _ state: TortoiseState) {
        addEvent(.tortoiseDidAddToOtherCanvas(uuid, state))
    }

    // MARK: - Private

    private enum Event {
        case tortoiseDidInitialize(UUID, TortoiseState)
        case tortoiseDidChangePosition(UUID, TortoiseState)
        case tortoiseDidChangeHeading(UUID, TortoiseState)
        case tortoiseDidChangePen(UUID, TortoiseState)
        case tortoiseDidChangeShape(UUID, TortoiseState)
        case tortoiseDidRequestToFill(UUID, TortoiseState)
        case tortoiseDidRequestToClear(UUID, TortoiseState)
        case tortoiseDidAddToOtherCanvas(UUID, TortoiseState)
        case canvasDidChangeBackground(Color)
        case canvasDidChangeSize(CGSize)
    }

    private let lock = NSLock()
    private var eventQueue: [Event] = []
    private var isHandling: Bool = false

    private var imageCanvas: ImageCanvas
    private var frameObservation: NSKeyValueObservation?

    private var tortoiseShapeLayers: [UUID: CAShapeLayer] = [:]

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
        case .tortoiseDidInitialize(let uuid, let state):
            handleInitializeEvent(uuid, state, completion)
        case .tortoiseDidChangePosition(let uuid, let state):
            handleChangePositionEvent(uuid, state, completion)
        case .tortoiseDidChangeHeading(let uuid, let state):
            handleChangeHeadingEvent(uuid, state, completion)
        case .tortoiseDidChangePen(let uuid, let state):
            handleChangePenEvent(uuid, state, completion)
        case .tortoiseDidChangeShape(let uuid, let state):
            handleChangeShapeEvent(uuid, state, completion)
        case .tortoiseDidRequestToFill(let uuid, let state):
            handleRequestToFillEvent(uuid, state, completion)
        case .tortoiseDidRequestToClear(let uuid, let state):
            handleRequestToClearEvent(uuid, state, completion)
        case .tortoiseDidAddToOtherCanvas(let uuid, let state):
            handleAddToOtherCanvasEvent(uuid, state, completion)
        case .canvasDidChangeBackground(let color):
            handleChangeBackgroundEvent(color, completion)
        case .canvasDidChangeSize(let size):
            handleChangeSizeEvent(size, completion)
        }
    }

    private func handleInitializeEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        CATransaction.transactionWithoutAnimation({
            let shapeLayer = CAShapeLayer()
            layer.addSublayer(shapeLayer)
            tortoiseShapeLayers[uuid] = shapeLayer

            shapeLayer.position = translatedPosition(position: state.position.toCGPoint())
            shapeLayer.transform = rotatedTransform(angle: state.heading)
            shapeLayer.path = makeShapePath(shape: state.shape,
                                            penSize: CGFloat(state.pen.width))
            shapeLayer.strokeColor = state.pen.color.toCGColor()
            shapeLayer.lineWidth = CGFloat(state.pen.width)
            shapeLayer.fillColor = state.pen.fillColor.toCGColor()
        }, completion: { [weak self] in
            self?.layer.contents = self?.imageCanvas.cgImage
            completion()
        })
    }

    private func handleChangePositionEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        let shapeLayer = tortoiseShapeLayers[uuid]

        let fromPos = shapeLayer?.position ?? .zero
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
            shapeLayer?.add(shapeAnimation, forKey: "shape-position)")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidChangePosition(uuid, state)
            self?.layer.contents = self?.imageCanvas.cgImage
            pathLayer?.removeFromSuperlayer()

            CATransaction.transactionWithoutAnimation({
                shapeLayer?.position = toPos
            }, completion: completion)
        })
    }

    private func handleChangeHeadingEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        let shapeLayer = tortoiseShapeLayers[uuid]

        let toTransform = rotatedTransform(angle: state.heading)

        CATransaction.transaction({
            let shapeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
            shapeAnimation.toValue = toTransform
            shapeAnimation.duration = state.speed.animationDuration()
            shapeLayer?.add(shapeAnimation, forKey: "shape-transform")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidChangeHeading(uuid, state)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                shapeLayer?.transform = toTransform
            }, completion: completion)
        })
    }

    private func handleChangePenEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        let shapeLayer = tortoiseShapeLayers[uuid]
        shapeLayer?.strokeColor = state.pen.color.toCGColor()
        shapeLayer?.lineWidth = CGFloat(state.pen.width)
        shapeLayer?.fillColor = state.pen.fillColor.toCGColor()
        handleChangeShapeEvent(uuid, state, completion)
    }

    private func handleChangeShapeEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        let shapeLayer = tortoiseShapeLayers[uuid]

        let toPath = makeShapePath(shape: state.shape,
                                   penSize: CGFloat(state.pen.width))
        let toOpacity: Float = state.shape.isVisible ? 1 : 0

        CATransaction.transaction({
            let animationDuration = state.speed.animationDuration()

            let anim1 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
            anim1.toValue = toPath
            anim1.duration = animationDuration
            shapeLayer?.add(anim1, forKey: "shape-path")

            let anim2 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
            anim2.toValue = toOpacity
            anim2.duration = animationDuration
            shapeLayer?.add(anim2, forKey: "shape-opacity")

        }, completion: { [weak self] in
            self?.imageCanvas.tortoiseDidChangeShape(uuid, state)
            self?.layer.contents = self?.imageCanvas.cgImage

            CATransaction.transactionWithoutAnimation({
                shapeLayer?.path = toPath
                shapeLayer?.opacity = toOpacity
            }, completion: completion)
        })
    }

    private func handleRequestToFillEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        guard let fillPath = state.fillPath else {
            completion()
            return
        }

        let fillLayer = CAShapeLayer()
        self.layer.addSublayer(fillLayer)
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
            self?.imageCanvas.tortoiseDidRequestToFill(uuid, state)
            self?.layer.contents = self?.imageCanvas.cgImage
            fillLayer.removeFromSuperlayer()
            completion()
        })
    }

    private func handleRequestToClearEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        imageCanvas.tortoiseDidRequestToClear(uuid, state)
        layer.contents = imageCanvas.cgImage
        completion()
    }

    private func handleAddToOtherCanvasEvent(_ uuid: UUID, _ state: TortoiseState, _ completion: @escaping () -> Void) {
        if let shapeLayer = tortoiseShapeLayers[uuid] {
            shapeLayer.removeFromSuperlayer()
            tortoiseShapeLayers[uuid] = nil
        }
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
