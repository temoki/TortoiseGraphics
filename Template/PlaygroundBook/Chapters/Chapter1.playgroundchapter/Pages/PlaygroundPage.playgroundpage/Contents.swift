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
let canvas = SwiftPlaygroundCanvas()
canvas.add(🐢)
//#-end-hidden-code
//#-editable-code
🐢.penUp()
🐢.back(100)
🐢.penDown()

// Turtle Star!
🐢.penColor(.red)
🐢.fillColor(.yellow)
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(200)
    🐢.left(170)
}
🐢.endFill()
//#-end-editable-code
//#-hidden-code
//PlaygroundPage.current.assessmentStatus = .pass(message: nil)
//#-end-hidden-code
