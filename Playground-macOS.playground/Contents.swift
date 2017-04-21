import PlaygroundSupport
import Cocoa
import TortoiseGraphics

let size = CGSize(width: 300, height: 300)
let canvas = Canvas(size: size)

canvas.🐢
    .right(30)
    .forward(100)
    .right(120)
    .forward(100)
    .right(120)
    .forward(100)

let cgImage = canvas.draw()
let image = NSImage(cgImage: cgImage!, size: .zero)
let imageView = NSImageView(frame: NSRect(origin: .zero, size: size))
imageView.image = image
PlaygroundPage.current.liveView = imageView