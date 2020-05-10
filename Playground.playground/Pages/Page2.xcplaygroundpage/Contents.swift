//: # Let's play with 🐢🐇
//: [👈 Previous](@previous)
import UIKit
import PlaygroundSupport
import TortoiseGraphics

let liveView = PlaygroundCanvasLiveView()
PlaygroundPage.current.liveView = liveView

let 🐢 = Tortoise()
let 🐇 = Tortoise()
liveView.canvas.add(🐢)
liveView.canvas.add(🐇)

🐢.shape(.tortoise)
🐇.shape(.classic)

🐢.penColor(.red)
🐢.fillColor(.orange)
🐢.left(90)

🐇.penColor(.purple)
🐇.fillColor(.lightBlue)
🐇.right(90)

// Turtle Star!
🐢.beginFill()
🐇.beginFill()
36.timesRepeat {
    🐢.forward(120)
    🐇.forward(120)
    🐢.left(170)
    🐇.right(170)
}
🐢.endFill()
🐇.endFill()
