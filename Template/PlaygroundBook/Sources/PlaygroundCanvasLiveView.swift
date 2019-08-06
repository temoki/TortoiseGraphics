#if os (iOS)
import UIKit

public class PlaygroundCanvasLiveView: UIViewController {

    public var canvas: Canvas {
        return playgroundCanvas
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playgroundCanvas.canvasDidLayout()
    }

    private lazy var playgroundCanvas: PlaygroundCanvas = {
        let canvas = PlaygroundCanvas(size: Vec2D(size: view.bounds.size))
        canvas.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvas)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: canvas.topAnchor),
            view.bottomAnchor.constraint(equalTo: canvas.bottomAnchor),
            view.leftAnchor.constraint(equalTo: canvas.leftAnchor),
            view.rightAnchor.constraint(equalTo: canvas.rightAnchor)
            ])
        return canvas
    }()

}
#endif

