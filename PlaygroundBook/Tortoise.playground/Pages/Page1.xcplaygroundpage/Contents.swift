//: # Let's play with 🐢
//#-hidden-code
//#-code-completion(identifier, hide, Canvas, ImageCanvas, GraphicsCanvas PlaygroundCanvas, View, Tortoise, PlaygroundLiveViewController, liveView, canvas. tortoises)
import UIKit
import PlaygroundSupport

let canvas = XCPlaygroundCanvas(size: Vec2D(300, 300))
PlaygroundPage.current.liveView = canvas

//#-end-hidden-code
let 🐢 = Tortoise()
//#-hidden-code
canvas.add(🐢)
//#-end-hidden-code
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
