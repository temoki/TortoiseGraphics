//: # Let's play with 🐢🐇
//#-hidden-code
//#-code-completion(identifier, hide, Canvas, ImageCanvas, GraphicsCanvas PlaygroundCanvas, View, Tortoise, PlaygroundLiveViewController, liveView, canvas. tortoises)
import UIKit
import PlaygroundSupport

let canvas = XCPlaygroundCanvas(size: Vec2D(300, 300))
PlaygroundPage.current.liveView = canvas

//#-end-hidden-code
let 🐢 = Tortoise()
let 🐇 = Tortoise()
//#-hidden-code
canvas.add(🐢)
canvas.add(🐇)
//#-end-hidden-code
🐢.penColor(.red)
🐢.fillColor(.orange)
🐢.left(90)

🐇.shape(.classic)
🐇.penColor(.purple)
🐇.fillColor(.lightBlue)
🐇.right(90)

// Turtle Star!
🐢.beginFill()
🐇.beginFill()
🐢.repeat(36) {
    🐢.forward(120)
    🐇.forward(120)
    🐢.left(170)
    🐇.right(170)
}
🐢.endFill()
🐇.endFill()
