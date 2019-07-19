//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let size = CGRect(x: 0, y: 0, width: 300, height: 300)
let canvas = XCPlaygroundCanvas(frame: size, color: Color.white)

PlaygroundPage.current.liveView = canvas
PlaygroundPage.current.needsIndefiniteExecution = true

let t = Tortoise(canvas: canvas)
t.forward(20)
t.forward(20)
t.forward(20)
