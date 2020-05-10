import Foundation
import PlaygroundSupport

public class SwiftPlaygroundCanvas: Canvas {

    public init() {
        self.proxy = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy
        self.proxy?.delegate = self
        send(MessageToLiveView(message: .canvasDidRequestReset(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }

    // MARK: - Canvas

    public func add(_ tortoise: Tortoise) {
        guard tortoise.delegate !== self else { return }
        tortoise.delegate?.tortoiseDidAddToOtherCanvas(tortoise.uuid, tortoise.state)
        tortoise.delegate = self
        tortoiseDidInitialized(tortoise.uuid, tortoise.state)
    }

    public private(set) var canvasSize: Vec2D = .zero

    public func canvasColor(_ r: Double, _ g: Double, _ b: Double) {
        canvasColor = Color(r, g, b)
        send(MessageToLiveView(message: .canvadDidChangeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }

    public func canvasColor(_ hex: String) {
        canvasColor = Color(hex)
        send(MessageToLiveView(message: .canvadDidChangeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }

    public func canvasColor(_ color: Color) {
        canvasColor = color
        send(MessageToLiveView(message: .canvadDidChangeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }

    public private(set) var canvasColor: Color = .white

    // MARK: - Private

    private let proxy: PlaygroundRemoteLiveViewProxy?

    private func send(_ message: MessageToLiveView) {
        if let proxy = self.proxy, let data = try? JSONEncoder().encode(message) {
            proxy.send(.data(data))
        }
    }
}

// MARK: - TortoiseDelegate

extension SwiftPlaygroundCanvas: TortoiseDelegate {

    func tortoiseDidInitialized(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidInitialize(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidChangePosition(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidChangePosition(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidChangeHeading(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidChangeHeading(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidChangePen(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidChangePen(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidChangeShape(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidChangeShape(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidRequestToFill(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidRequestFill(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidRequestToClear(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .tortoiseDidRequestClear(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }

    func tortoiseDidAddToOtherCanvas(_ uuid: UUID, _ state: TortoiseState) {
        // Nothing to do
    }

}

// MARK: - PlaygroundRemoteLiveViewProxyDelegate

extension SwiftPlaygroundCanvas: PlaygroundRemoteLiveViewProxyDelegate {

    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
    }

    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
        guard case .data(let data) = message else { return }
        guard let messageToRemote = try? JSONDecoder().decode(MessageToRemote.self, from: data) else { return }
        switch messageToRemote.message {
        case .canvasSize(let size):
            canvasSize = size
        case .canvasColor(let color):
            canvasColor = color
        }
    }

}
