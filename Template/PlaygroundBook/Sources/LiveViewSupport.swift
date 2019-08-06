import UIKit
import PlaygroundSupport

public func instantiateLiveView() -> PlaygroundLiveViewable {
    let liveView = LiveViewController()
    let 🐢 = Tortoise()
    liveView.canvas.add(🐢)
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
        🐢.penUp()
        🐢.back(100)
        🐢.penDown()
        
        // Turtle Star!
        🐢.penColor(.blue)
        🐢.fillColor(.deepPurple)
        🐢.beginFill()
        🐢.repeat(36) {
            🐢.forward(200)
            🐢.left(170)
        }
        🐢.endFill()
    }
    return liveView
}
