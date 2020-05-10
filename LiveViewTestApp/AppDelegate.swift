//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Implements the application delegate for LiveViewTestApp with appropriate configuration points.
//

import UIKit
import PlaygroundSupport
import LiveViewHost
import Book_Sources

@UIApplicationMain
class AppDelegate: LiveViewHost.AppDelegate {

    override func setUpLiveView() -> PlaygroundLiveViewable {
        let liveView = instantiateLiveView()

        // Check code
        do {
            let 🐢 = Tortoise()
            liveView.canvas.add(🐢)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                🐢.penUp()
                🐢.back(100)
                🐢.penDown()

                // Turtle Star!
                🐢.penColor(.red)
                🐢.fillColor(.yellow)
                🐢.beginFill()

                repeating(36) {
                    🐢.forward(200)
                    🐢.left(170)
                }
                🐢.endFill()
            }
        }

        return liveView
    }

    override var liveViewConfiguration: LiveViewConfiguration {
        return .fullScreen
    }

}
