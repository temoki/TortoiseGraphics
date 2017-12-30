#if os(iOS)
import UIKit

public class PlaygroundLiveViewController: UIViewController {
    
    private var backView: UIView!
    public var canvas: PlaygroundCanvas!
    
    public override func viewDidLoad() {
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
        canvas.color = .white
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
#endif
