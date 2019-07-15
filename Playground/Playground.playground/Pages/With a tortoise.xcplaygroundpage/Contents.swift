//: # With a tortoise 🐢
//: [👉 With 2 tortoises 🐢🐢](@next)
import PlaygroundSupport
import AppKit
import TortoiseGraphics
import CoreGraphics

let size = CGSize(width: 300, height: 300)
let canvas = ImageCanvas(size: size, scale: 2)
let t = Tortoise(name: "", canvas: canvas)
t.forward(100)

let imageView = NSImageView(frame: NSRect(origin: .zero, size: size))
PlaygroundPage.current.liveView = imageView
imageView.image = canvas.cgImage.map { NSImage(cgImage: $0, size: size) }

t.forward(-200)
imageView.image = canvas.cgImage.map { NSImage(cgImage: $0, size: size) }


