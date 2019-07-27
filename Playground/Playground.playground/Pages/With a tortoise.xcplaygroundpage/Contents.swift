//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let canvas = XCPlaygroundCanvas(size: CGSize(width: 300, height: 300))
PlaygroundPage.current.liveView = canvas

let t = Tortoise(canvas: canvas)
t.fd(90)
t.rt(90)
t.fd(90)
t.home()
