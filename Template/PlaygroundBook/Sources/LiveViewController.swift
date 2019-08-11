import UIKit
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
public class LiveViewController: PlaygroundCanvasLiveView, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    // MARK: - PlaygroundCanvasLiveView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        log(#function)
        send(MessageToRemote(message: .canvasColor(canvas.canvasColor)))
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        log(#function)
        send(MessageToRemote(message: .canvasSize(Vec2D(size: view.bounds.size))))
    }
    
    
    // MARK: - PlaygroundLiveViewMessageHandler

    // Implement this method to be notified when the live view message connection is opened.
    // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    public func liveViewMessageConnectionOpened() {
        log(#function)
    }
    
    // Implement this method to be notified when the live view message connection is closed.
    // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
    // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    public func liveViewMessageConnectionClosed() {
        log(#function)
    }
    
    // Implement this method to receive messages sent from the process running Contents.swift.
    // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
    // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
    public func receive(_ message: PlaygroundValue) {
        log(#function)
        guard case .data(let data) = message else { return }
        guard let messageToLiveView = try? JSONDecoder().decode(MessageToLiveView.self, from: data) else { return }

        switch messageToLiveView.message {
        case .initialize(let tortoiseMmessage):
            log(#function + ".initialize")
            playgroundCanvas.addEvent(.tortoiseDidInitialize(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .changePosition(let tortoiseMmessage):
            log(#function + ".changePosition")
            playgroundCanvas.addEvent(.tortoiseDidChangePosition(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .changeHeading(let tortoiseMmessage):
            log(#function + ".changeHeading")
            playgroundCanvas.addEvent(.tortoiseDidChangeHeading(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .changePen(let tortoiseMmessage):
            log(#function + ".changePen")
            playgroundCanvas.addEvent(.tortoiseDidChangePen(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .changeShape(let tortoiseMmessage):
            log(#function + ".changeShape")
            playgroundCanvas.addEvent(.tortoiseDidChangeShape(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .requestFill(let tortoiseMmessage):
            log(#function + ".requestFill")
            playgroundCanvas.addEvent(.tortoiseDidRequestToFill(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .requestClear(let tortoiseMmessage):
            log(#function + ".requestClear")
            playgroundCanvas.addEvent(.tortoiseDidRequestToClear(tortoiseMmessage.uuid, tortoiseMmessage.state))

        case .changeBackgroud(let canvasMessage):
            log(#function + ".changeBackgroud")
            playgroundCanvas.addEvent(.canvasDidChangeBackground(canvasMessage.color))
        }
    }
    
    
    // MARK: - Private
    
    private lazy var debugConsole: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .red
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: textView.topAnchor),
            view.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: textView.leftAnchor),
            view.rightAnchor.constraint(equalTo: textView.rightAnchor)
            ])
        return textView
    }()
    
    private let isLogEnabled: Bool = true

    private var log: [String] = []
    
    private func log(_ message: String) {
        guard isLogEnabled else { return }
        log.append(message)
        if log.count > 100 {
            log.remove(at: 0)
        }
        debugConsole.text = log.joined(separator: "\n")
    }
    
    private func send(_ message: MessageToRemote) {
        if let data = try? JSONEncoder().encode(message) {
            send(.data(data))
        }
    }
    
    

}
