import CoreGraphics

struct State {

    var position: CGPoint = .zero

    var heading: CGFloat = 0

    var isPenDown: Bool = true

    var penSize: CGFloat = 1

    var penColor: CGColor = Color.black.cgColor

    var isVisible: Bool = true

    var canvasSize: CGSize = .zero

    var canvasColor: CGColor = Color.white.cgColor

    func apply(to cgContext: CGContext) {
        cgContext.move(to: position)
        cgContext.setLineWidth(penSize)
        cgContext.setStrokeColor(penColor)
        cgContext.setFillColor(canvasColor)
    }

}
