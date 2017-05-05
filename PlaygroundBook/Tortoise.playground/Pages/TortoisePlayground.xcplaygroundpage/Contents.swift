//#-hidden-code
import UIKit
import PlaygroundSupport

let view = CanvasView(canvasSize: CGSize(width: 512, height: 768))
PlaygroundPage.current.liveView = view

var animationInterval: TimeInterval = 0.1
defer { view.animate(atTimeInterval: animationInterval) }
let 🐢 = view.canvas.🐢
let tortoise = 🐢
🐢.clearScreen()
//#-code-completion(identifier, hide, view)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: Hello, TortoiseGraphics! 🐢

//#-editable-code Tap to write your code
animationInterval = 0.05

🐢.setPenColor { $0.random(18) + 1 }
    .right(234)
    .make("i", 1)
    .repeat(100) { $0
        .forward { $0["i"] * 0.9 }
        .right(144.3)
        .make("i") { $0["i"] + 5 }
    }
    .home()

//#-end-editable-code
