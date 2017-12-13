import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
canvas.animationInterval = 0.01
PlaygroundPage.current.liveView = canvas

canvas.play { 🐢 in
    🐢.penColor(.red)
    🐢.fillColor(.yellow)

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
}
