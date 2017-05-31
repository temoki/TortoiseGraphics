import CoreGraphics

struct State {

    var position: CGPoint = .zero

    var heading: CGFloat = 0

    var isPenDown: Bool = true

    var penSize: CGFloat = 1

    var penColor: CGColor = Color.black.cgColor

    var isVisible: Bool = true

}
