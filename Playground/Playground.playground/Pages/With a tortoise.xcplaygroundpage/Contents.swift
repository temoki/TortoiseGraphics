//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import TortoiseGraphics

let canvas = XCPlaygroundCanvas(size: Vec2D(300, 300))
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

