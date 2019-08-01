//: # Let's play with 🐢🐇
//#-code-completion(identifier, hide, Canvas, ImageCanvas, PlaygroundCanvas, PlaygroundCanvasLiveView, liveView)
//#-hidden-code
import UIKit
import PlaygroundSupport
let liveView = PlaygroundCanvasLiveView()
let canvas = liveView.canvas
PlaygroundPage.current.liveView = liveView
//#-end-hidden-code

let 🐢 = Tortoise()
let 🐇 = Tortoise()
canvas.add(🐢)
canvas.add(🐇)

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
