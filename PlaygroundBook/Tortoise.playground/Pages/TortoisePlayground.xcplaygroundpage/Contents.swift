//#-hidden-code
import UIKit
import PlaygroundSupport

let baseView = UIView(frame: CGRect(x: 0, y: 0, width: 512, height: 768))

let backView = UIView(frame: baseView.bounds)
backView.backgroundColor = .white
backView.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
baseView.addSubview(backView)

let canvas = Canvas(frame: baseView.bounds)
canvas.backgroundColor = .clear
canvas.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
baseView.addSubview(canvas)

PlaygroundPage.current.liveView = baseView

canvas.play { (tortoise) in
    let 🐢 = tortoise
//#-code-completion(identifier, hide, Canvas, TortoisePlayground, baseView, backView, canvas)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: # Let's play with 🐢!
//#-editable-code
    🐢.penColor(.blue)
    
    func hexagon(_ side: Double) {
        🐢.repeat(6) {
            🐢.forward(side)
            🐢.right(60)
        }
    }
    
    var side: Double = 0
    🐢.repeat(24) {
        side += 3
        hexagon(side)
        🐢.right(15)
    }
//#-end-editable-code
//#-hidden-code
} // end of play
//#-end-hidden-code
