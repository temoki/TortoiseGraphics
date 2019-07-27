//: # With 2 tortoises 🐢🐢
//: [👈 With a tortoise 🐢](@previous)
import PlaygroundSupport
import TortoiseGraphics

let canvas = XCPlaygroundCanvas(size: Vec2D(300, 300))
PlaygroundPage.current.liveView = canvas

let 🐢 = Tortoise(canvas: canvas)
let 🐇 = Tortoise(canvas: canvas)
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
🐢.repeat(36) {
    🐢.forward(120)
    🐇.forward(120)
    🐢.left(170)
    🐇.right(170)
}
🐢.endFill()
🐇.endFill()


