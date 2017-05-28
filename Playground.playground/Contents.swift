import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
PlaygroundPage.current.liveView = canvas

let t = canvas.tortoise

for j in 0..<100 {
    for i in 1...4 {
        t.forward(100)
        t.right(90)
        //print(t.heading)
        //print(t.position)
    }
    t.right(3)
}

canvas.draw(animated: true)