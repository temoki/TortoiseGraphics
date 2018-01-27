//: # With 2 tortoises 🐢🐢
//: [👈 With a tortoise 🐢](@previous)
import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvas = PlaygroundCanvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
canvas.frameRate = 30
canvas.color = .white
PlaygroundPage.current.liveView = canvas

canvas.drawingWithTortoises(count: 2) { tortoises in
    let 🐢 = tortoises[0]
    let 🐇 = tortoises[1]
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
}

