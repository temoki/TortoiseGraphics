//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import TortoiseGraphics
import UIKit

let canvas = XCPlaygroundCanvas(size: CGSize(width: 300, height: 300))
PlaygroundPage.current.liveView = canvas

let 🐢 = Tortoise(canvas: canvas)

// Turtle Star!
🐢.speed(.fastest)
🐢.penColor(.blue)
🐢.fillColor(.deepPurple)
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(100)
    🐢.left(170)
}
🐢.endFill()

