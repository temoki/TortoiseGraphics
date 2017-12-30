import CoreGraphics

public class GraphicsCanvas: Canvas {

    private var tortoiseCharmer = TortoiseCharmer(tortoiseCount: 0)
    private let graphicsContext: GraphicsContext

    public init(size: CGSize, context: CGContext) {
        #if os(iOS)
            let isUIViewContext = true
        #else
            let isUIViewContext = false
        #endif
        self.graphicsContext = GraphicsContext(size: size,
                                               cgContext: context,
                                               backgroundColor: color?.cgColor,
                                               isUIViewContext: isUIViewContext)
    }

    // MARK: - Canvas Protocol

    public func drawing(drawingBlock: @escaping (Tortoise) -> Void) {
        tortoiseCharmer.initialize(tortoiseCount: 1)
        drawingBlock(tortoiseCharmer.tortoises[0])
        tortoiseCharmer.charm(with: graphicsContext, toFrame: nil)
    }

    public func drawingWithTortoises(count: Int, drawingBlock: @escaping ([Tortoise]) -> Void) {
        tortoiseCharmer.initialize(tortoiseCount: count)
        drawingBlock(tortoiseCharmer.tortoises)
        tortoiseCharmer.charm(with: graphicsContext, toFrame: nil)
    }

    public var color: Color?

}
