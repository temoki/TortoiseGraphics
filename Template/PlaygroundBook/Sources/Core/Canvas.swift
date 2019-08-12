import Foundation

public protocol Canvas {

    func add(_ tortoise: Tortoise)

    var canvasSize: Vec2D { get }

    func canvasColor(_ palette: ColorPalette)

    func canvasColor(_ r: Double, _ g: Double, _ b: Double)

    func canvasColor(_ hex: String)

    func canvasColor(_ color: Color)

    var canvasColor: Color { get }

}
