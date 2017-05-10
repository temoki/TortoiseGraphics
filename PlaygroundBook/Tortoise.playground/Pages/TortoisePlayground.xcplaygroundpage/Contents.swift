//#-hidden-code
import UIKit
import PlaygroundSupport
TortoisePlayground.main.liveView.frame = CGRect(x: 0, y: 0, width: 512, height: 768)
PlaygroundPage.current.liveView = TortoisePlayground.main.liveView
TortoisePlayground.main.start(withTimeInterval: 0.01)
//#-code-completion(identifier, hide, Canvas, CanvasView, Image, View, Procedure, Properties)
//#-code-completion(identifier, hide, Tortoise, NumberOutput, BoolOutput, DrawingHandler)
//#-code-completion(identifier, hide, TortoisePlayground)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: ### Hello, Tortoise Graphics! 🐢
//#-editable-code

setPenColor(random(18) + 1)
right(234)
for i in 1...100 {
    forward(Number(i * 5) * 0.9)
    right(144.3)
}
home()

//#-end-editable-code
//#-hidden-code
TortoisePlayground.main.finish {
    // !!UNCOMMENT NEXT LINE BEFORE BUILD!!
    //PlaygroundPage.current.assessmentStatus = .pass(message: "🐢> Finished!")
}
//#-end-hidden-code
