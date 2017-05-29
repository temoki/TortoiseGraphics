import CoreGraphics

struct State {

    // MARK: - Tortoise's State

    var position: CGPoint = .zero

    var heading: CGFloat = 0

    // MARK: - Drawing State

    var isPenDown: Bool = true

    var penSize: CGFloat = 1

    // MARK: - Tortoise's Visibility

    var isVisible: Bool = true

}
