//: # Let's play with 🐢
import UIKit
import PlaygroundSupport
import TortoiseGraphics

let liveView = PlaygroundCanvasLiveView()
PlaygroundPage.current.liveView = liveView

let 🐢 = Tortoise()
liveView.canvas.add(🐢)


🐢.penUp()
🐢.back(100)
🐢.penDown()

// Turtle Star!
🐢.penColor(.red)
🐢.fillColor(.yellow)
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(200)
    🐢.left(170)
}
🐢.endFill()
