//#-code-completion(identifier, hide, Canvas)
//#-code-completion(identifier, hide, ImageCanvas)
//#-code-completion(identifier, hide, instantiateLiveView())
//#-code-completion(identifier, hide, LiveViewController)
//#-code-completion(identifier, hide, PlaygroundCanvas)
//#-code-completion(identifier, hide, PlaygroundCanvasLiveView)
//#-code-completion(identifier, hide, SwiftPlaygroundCanvas)
//#-code-completion(identifier, hide, Tortoise)
//#-hidden-code
import Foundation
import PlaygroundSupport
let 🐢 = Tortoise()
let 🐇 = Tortoise()
let canvas = SwiftPlaygroundCanvas()
canvas.add(🐢)
canvas.add(🐇)
🐢.shape(.tortoise)
🐇.shape(.classic)
//#-end-hidden-code
//#-editable-code
🐢.penColor(.red)
🐢.fillColor(.orange)
🐢.left(90)

🐇.penColor(.purple)
🐇.fillColor(.lightBlue)
🐇.right(90)

// Turtle Star!
🐢.beginFill()
🐇.beginFill()
🐢.repeat(36) {
    🐢.forward(120)
    🐇.forward(120)
    🐢.left(170)
    🐇.right(170)
}
🐢.endFill()
🐇.endFill()
//#-end-editable-code
//#-hidden-code
//PlaygroundPage.current.assessmentStatus = .pass(message: nil)
//#-end-hidden-code
