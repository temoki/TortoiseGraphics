import UIKit
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
public class LiveViewController: PlaygroundCanvasLiveView, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    // MARK: - PlaygroundCanvasLiveView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        send(MessageToRemote(message: .canvasColor(canvas.canvasColor)))
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        send(MessageToRemote(message: .canvasSize(Vec2D(size: view.bounds.size))))
    }
    
    
    // MARK: - PlaygroundLiveViewMessageHandler

    // Implement this method to be notified when the live view message connection is opened.
    // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    public func liveViewMessageConnectionOpened() {
    }
    
    // Implement this method to be notified when the live view message connection is closed.
    // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
    // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    public func liveViewMessageConnectionClosed() {
    }
    
    // Implement this method to receive messages sent from the process running Contents.swift.
    // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
    // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
    public func receive(_ message: PlaygroundValue) {
    }
    
    
    // MARK: - Private
    
    private func send(_ message: MessageToRemote) {
        if let data = try? JSONEncoder().encode(message) {
            send(.data(data))
        }
    }

}
