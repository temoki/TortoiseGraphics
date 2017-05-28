import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvasView = CanvasView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
PlaygroundPage.current.liveView = canvasView

let t = canvasView.tortoise

for i in 1...4 {
    t.forward(100)
    t.right(90)
    print(t.heading)
    print(t.position)
}

canvasView.setNeedsDisplay(canvasView.frame)