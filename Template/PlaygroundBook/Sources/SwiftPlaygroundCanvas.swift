import Foundation
import PlaygroundSupport

public class SwiftPlaygroundCanvas: Canvas {
    
    var proxy: PlaygroundRemoteLiveViewProxy?
    
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
        
        // TODO: send
    }
    
    public func canvasColor(_ r: Double, _ g: Double, _ b: Double) {
        canvasColor = Color(r, g, b)
        send(LiveViewController.ReceiveMessage(canvasColor: canvasColor))
    }
    
    public func canvasColor(_ hex: String) {
        canvasColor = Color(hex)
        send(LiveViewController.ReceiveMessage(canvasColor: canvasColor))
    }
    
    public func canvasColor(_ color: Color) {
        canvasColor = color
        send(LiveViewController.ReceiveMessage(canvasColor: canvasColor))
    }
    
    public private(set) var canvasColor: Color = ColorPalette.white.color

    
    // MARK: - Private
    
    private func send(_ message: LiveViewController.ReceiveMessage) {
        if let proxy = self.proxy, let data = try? JSONEncoder().encode(message) {
            proxy.send(.data(data))
        }
    }
}

// MARK: - TortoiseDelegate

extension SwiftPlaygroundCanvas: TortoiseDelegate {
    
    func tortoiseDidInitialized(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidChangePosition(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidChangeHeading(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidChangePen(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidChangeShape(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidRequestToFill(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidRequestToClear(_ uuid: UUID, _ state: TortoiseState) {
        
    }
    
    func tortoiseDidAddToOtherCanvas(_ uuid: UUID, _ state: TortoiseState) {
        
    }

}

// MARK: - PlaygroundRemoteLiveViewProxyDelegate

extension SwiftPlaygroundCanvas: PlaygroundRemoteLiveViewProxyDelegate {
    
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
    }
    
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
        guard case .data(let data) = message else { return }
        guard let message = try? JSONDecoder().decode(LiveViewController.SendMessage.self, from: data) else { return }
        self.canvasSize = message.canvasSize ?? self.canvasSize
        self.canvasColor = message.canvasColor ?? self.canvasColor
    }
 
}
