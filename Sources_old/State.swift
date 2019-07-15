import CoreGraphics

struct State {

    var position: CGPoint = .zero

    var heading: Degree = Degree(0)

    var isPenDown: Bool = true

    var penSize: CGFloat = 1

    var penColor: CGColor = Color.black.cgColor

    var fillColor: CGColor = Color.black.cgColor

    var isVisible: Bool = true

    var fillPath: CGMutablePath?

    var canvasSize: CGSize = .zero

    var shape: Shape = .tortoise

}
