import Foundation
import TortoiseGraphics

let canvas = ImageCanvas(size: CGSize(width: 300, height: 300))
canvas.color = .white
canvas.drawing { 🐢 in
    🐢.right(90)
    🐢.forward(100)
}
canvas.writePNG(to: URL(fileURLWithPath: "./output.png"))
