//#-hidden-code
import UIKit
import PlaygroundSupport

let liveView = PlaygroundLiveViewController()
PlaygroundPage.current.liveView = liveView

liveView.canvas.drawing { 🐢 in
//#-code-completion(identifier, hide, Canvas, ImageCanvas, GraphicsCanvas PlaygroundCanvas, View, Tortoise, PlaygroundLiveViewController, liveView, canvas. tortoises)
//#-end-hidden-code
//: # Let's play with 🐢
    🐢.penColor(.red)
    🐢.fillColor(.orange)
    
    🐢.penUp()
    🐢.back(100)
    🐢.penDown()
    
    // Turtle Star!
    🐢.beginFill()
    🐢.repeat(36) {
        🐢.forward(200)
        🐢.left(170)
    }
    🐢.endFill()
//#-hidden-code
}
