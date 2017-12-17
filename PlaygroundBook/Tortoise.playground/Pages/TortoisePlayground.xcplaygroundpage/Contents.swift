//#-hidden-code
import UIKit
import PlaygroundSupport

class PlaygroundLiveViewController: UIViewController {
    
    var backView: UIView!
    var canvas: PlaygroundCanvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        backView = UIView(frame: view.bounds)
        backView.backgroundColor = .white
        view.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        canvas = PlaygroundCanvas(frame: view.bounds)
        canvas.backgroundColor = .clear
        view.addSubview(canvas)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvas.leftAnchor.constraint(equalTo: view.leftAnchor),
            canvas.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
}
let liveView = PlaygroundLiveViewController()
PlaygroundPage.current.liveView = liveView

liveView.canvas.drawing { 🐢 in
//#-code-completion(identifier, hide, Canvas, ImageCanvas, PlaygroundCanvas, View, Tortoise, PlaygroundLiveViewController, liveView, canvas)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: # Let's play with 🐢
    🐢.penColor(.red)
    🐢.fillColor(.yellow)
    
    🐢.penUp()
    🐢.back(100)
    🐢.penDown()
    
    // Turtle Star!
    🐢.beginFill()
    🐢.repeat(36) {
        🐢.forward(200)
        🐢.left(170)
    }
    🐢.endFill()
//#-hidden-code
}
