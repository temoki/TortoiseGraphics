import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
canvas.animationInterval = 0.01
PlaygroundPage.current.liveView = canvas

canvas.play { 🐢 in

    🐢.penColor(.blue)

    func hexagon(_ side: Double) {
        🐢.repeat(6) {
            🐢.forward(side)
            🐢.right(60)
        }
    }
    
    var side: Double = 0
    🐢.repeat(24) {
        side += 3
        hexagon(side)
        🐢.right(15)
    }

}
