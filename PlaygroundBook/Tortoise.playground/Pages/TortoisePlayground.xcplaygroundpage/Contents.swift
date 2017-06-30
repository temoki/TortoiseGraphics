//#-hidden-code
import UIKit
import PlaygroundSupport

class PlaygroundLiveViewController: UIViewController {
    
    var backView: UIView!
    var canvas: Canvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.backView = UIView(frame: self.view.bounds)
        self.backView.backgroundColor = .white
        self.view.addSubview(self.backView)
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.backView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.backView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.canvas = Canvas(frame: self.view.bounds)
        self.canvas.backgroundColor = .clear
        self.view.addSubview(canvas)
        self.canvas.translatesAutoresizingMaskIntoConstraints = false
        self.canvas.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.canvas.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.canvas.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.canvas.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
}
let liveView = PlaygroundLiveViewController()
PlaygroundPage.current.liveView = liveView

liveView.canvas.play { 🐢 in
//#-code-completion(identifier, hide, Canvas, View, Tortoise, PlaygroundLiveViewController, liveView, canvas)
//#-code-completion(module, hide, UIKit, PlaygroundSupport)
//#-end-hidden-code
//: # Let's play with 🐢
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
//#-hidden-code
}
