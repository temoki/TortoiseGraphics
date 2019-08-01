//: # Let's play with 🐢

//#-code-completion(identifier, hide, Canvas, ImageCanvas, PlaygroundCanvas, PlaygroundCanvasLiveView, liveView)
//#-hidden-code
import UIKit
import PlaygroundSupport
let liveView = PlaygroundCanvasLiveView()
let canvas = liveView.canvas
PlaygroundPage.current.liveView = liveView
//#-end-hidden-code

let 🐢 = Tortoise()
canvas.add(🐢)

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
