import Foundation

struct Pen: Equatable, Codable {

    var isDown: Bool = true

    var color: Color = .black

    var width: Double = 1

    var fillColor: Color = .black

}
