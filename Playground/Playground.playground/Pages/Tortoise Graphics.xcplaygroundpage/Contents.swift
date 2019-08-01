//: # 🐢 Tortoise Graphics
import PlaygroundSupport
import TortoiseGraphics

let 🐢 = Tortoise()

let liveView = PlaygroundCanvasLiveView()
liveView.canvas.add(🐢)
PlaygroundPage.current.liveView = liveView

🐢.penUp()
🐢.back(100)
🐢.penDown()

// Turtle Star!
🐢.penColor(.blue)
🐢.fillColor(.deepPurple)
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(200)
    🐢.left(170)
}
🐢.endFill()
