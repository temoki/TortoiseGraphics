//#-hidden-code
import UIKit
import PlaygroundSupport

let baseVC = UIViewController()
//baseVC.view.frame = CGRect(x: 0, y: 0, width: 512, height: 768)
baseVC.view.translatesAutoresizingMaskIntoConstraints = false

let backView = UIView(frame: baseVC.view.bounds)
backView.backgroundColor = .white
baseVC.view.addSubview(backView)
backView.translatesAutoresizingMaskIntoConstraints = false
backView.topAnchor.constraint(equalTo: baseVC.view.topAnchor).isActive = true
backView.bottomAnchor.constraint(equalTo: baseVC.view.bottomAnchor).isActive = true
backView.leftAnchor.constraint(equalTo: baseVC.view.leftAnchor).isActive = true
backView.rightAnchor.constraint(equalTo: baseVC.view.rightAnchor).isActive = true

let canvas = Canvas(frame: baseVC.view.bounds)
canvas.backgroundColor = .clear
baseVC.view.addSubview(canvas)
canvas.translatesAutoresizingMaskIntoConstraints = false
canvas.topAnchor.constraint(equalTo: baseVC.view.topAnchor).isActive = true
canvas.bottomAnchor.constraint(equalTo: baseVC.view.bottomAnchor).isActive = true
canvas.leftAnchor.constraint(equalTo: baseVC.view.leftAnchor).isActive = true
canvas.rightAnchor.constraint(equalTo: baseVC.view.rightAnchor).isActive = true

PlaygroundPage.current.liveView = baseVC

canvas
//#-code-completion(identifier, hide, Canvas, View, Tortoise, baseVC, backView, canvas)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: # Let's play with 🐢
.play { 🐢 in
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
}
