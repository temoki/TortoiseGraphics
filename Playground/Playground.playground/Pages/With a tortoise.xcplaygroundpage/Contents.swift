//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let size = CGRect(x: 0, y: 0, width: 300, height: 300)
let canvas = XCPlaygroundCanvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                backgroundColor: Color.white)

PlaygroundPage.current.liveView = canvas

canvas.drawing { 🐢 in
    🐢.forward(10)
    🐢.forward(10)
    🐢.forward(10)
}

