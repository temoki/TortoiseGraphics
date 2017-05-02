import Foundation
import CoreGraphics
import TortoiseGraphics

let canvas = Canvas(size: CGSize(width: 300, height: 300))

canvas.🐢
    .penUp()
    .forward(50)
    .right(90)
    .forward(50)
    .penDown()
    .repeat(4) { $0
        .right(90)
        .forward(100)
    }

guard let image = canvas.draw() else {
    fatalError()
}

let url = URL(fileURLWithPath: "./output.png")
guard let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil) else {
    fatalError()
}

CGImageDestinationAddImage(destination, image, nil)
CGImageDestinationFinalize(destination)
