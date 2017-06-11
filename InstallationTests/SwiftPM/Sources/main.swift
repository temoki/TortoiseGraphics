import Foundation
import TortoiseGraphics
let 🐢 = Tortoise()
🐢.fd(100)
🐢.writePNG(of: CGSize(width: 300, height: 300), to: URL(fileURLWithPath: "./output.png"))
