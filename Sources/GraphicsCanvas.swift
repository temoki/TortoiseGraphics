import CoreGraphics

public class GraphicsCanvas {

    private let 🐢: Tortoise
    private let graphicsContext: GraphicsContext

    public init(size: CGSize, context: CGContext) {
        self.🐢 = Tortoise()
        #if os(iOS)
            let isUIViewContext = true
        #else
            let isUIViewContext = false
        #endif
        self.graphicsContext = GraphicsContext(size: size,
                                               cgContext: context,
                                               isUIViewContext: isUIViewContext)
    }

    // MARK: - Canvas Protocol

    public func drawing(_ block: @escaping (Tortoise) -> Void) {
        🐢.initialize()
        block(🐢)
        🐢.draw(with: graphicsContext, toFrame: nil)
    }

}
