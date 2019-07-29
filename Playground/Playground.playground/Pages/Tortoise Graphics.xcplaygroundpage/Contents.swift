//: # 🐢 Tortoise Graphics
import PlaygroundSupport
import TortoiseGraphics

let 🐢 = Tortoise("ホシガメ")

let canvas = XCPlaygroundCanvas(size: Vec2D(300, 300))
canvas.add(🐢)
PlaygroundPage.current.liveView = canvas


// Turtle Star!
🐢.penColor(.blue)
🐢.fillColor(.deepPurple)
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(100)
    🐢.left(170)
}
🐢.endFill()

