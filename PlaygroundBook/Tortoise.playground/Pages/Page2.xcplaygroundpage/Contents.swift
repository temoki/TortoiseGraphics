//#-hidden-code
import UIKit
import PlaygroundSupport

let liveView = PlaygroundLiveViewController()
PlaygroundPage.current.liveView = liveView

liveView.canvas.drawingWithTortoises(count: 2) { tortoises in
    let 🐢 = tortoises[0]
    let 🐇 = tortoises[1]
    🐢.shape(.tortoise)
    🐇.shape(.classic)
//#-code-completion(identifier, hide, Canvas, ImageCanvas, GraphicsCanvas PlaygroundCanvas, View, Tortoise, PlaygroundLiveViewController, liveView, canvas. tortoises)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: # Let's play with 🐢🐇
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
    //#-hidden-code
}

