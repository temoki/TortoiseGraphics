import Foundation

struct Pen: Equatable, Codable {

    var isDown: Bool = true

    var color: Color = ColorPalette.black.color

    var width: Double = 1

    var fillColor: Color = ColorPalette.black.color

}
