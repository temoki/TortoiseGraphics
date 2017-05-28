import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
PlaygroundPage.current.liveView = canvas

canvas.play { 🐢 in
    for _ in 1...36 {
        for _ in 1...4 {
            🐢.forward(100)
            🐢.right(90)
        }
        🐢.right(10)
    }
}
