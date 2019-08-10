import Foundation
import PlaygroundSupport

public class SwiftPlaygroundCanvas: Canvas {
    
    public init(liveView: PlaygroundLiveViewable?) {
        self.proxy = liveView as? PlaygroundRemoteLiveViewProxy
    }
    
    // MARK: - Canvas

    public func add(_ tortoise: Tortoise) {
        guard tortoise.delegate !== self else { return }
        tortoise.delegate?.tortoiseDidAddToOtherCanvas(tortoise.uuid, tortoise.state)
        tortoise.delegate = self
        tortoiseDidInitialized(tortoise.uuid, tortoise.state)
    }
    
    public private(set) var canvasSize: Vec2D = .zero
    
    
    public func canvasColor(_ palette: ColorPalette) {
        canvasColor = palette.color
        send(MessageToLiveView(message: .changeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }
    
    public func canvasColor(_ r: Double, _ g: Double, _ b: Double) {
        canvasColor = Color(r, g, b)
        send(MessageToLiveView(message: .changeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }
    
    public func canvasColor(_ hex: String) {
        canvasColor = Color(hex)
        send(MessageToLiveView(message: .changeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }
    
    public func canvasColor(_ color: Color) {
        canvasColor = color
        send(MessageToLiveView(message: .changeBackgroud(MessageToLiveView.CanvasMessage(color: canvasColor))))
    }
    
    public private(set) var canvasColor: Color = ColorPalette.white.color

    
    // MARK: - Private
    
    private weak var proxy: PlaygroundRemoteLiveViewProxy?
    
    private func send(_ message: MessageToLiveView) {
        if let proxy = self.proxy, let data = try? JSONEncoder().encode(message) {
            proxy.send(.data(data))
        }
    }
}

// MARK: - TortoiseDelegate

extension SwiftPlaygroundCanvas: TortoiseDelegate {
    
    func tortoiseDidInitialized(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .initialize(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidChangePosition(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .changePosition(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidChangeHeading(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .changeHeading(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidChangePen(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .changePen(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidChangeShape(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .changeShape(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidRequestToFill(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .requestFill(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidRequestToClear(_ uuid: UUID, _ state: TortoiseState) {
        send(MessageToLiveView(message: .requestClear(MessageToLiveView.TortoiseMessage(uuid: uuid, state: state))))
    }
    
    func tortoiseDidAddToOtherCanvas(_ uuid: UUID, _ state: TortoiseState) {
        // TODO: 不要なはず？
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
