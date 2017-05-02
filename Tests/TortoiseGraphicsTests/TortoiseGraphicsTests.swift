import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {
    
    func loadTortoise(scale: CGFloat) -> CGImage? {
        let url = URL(fileURLWithPath: "./Assets/Tortoise.pdf")
        let image = NSImage(byReferencing: url)
        var rect = CGRect(origin: .zero, size: image.size).applying(CGAffineTransform(scaleX: scale, y: scale))
        return image.cgImage(forProposedRect: &rect, context: nil, hints: nil)
    }

    func testOutputExample() {
        let scale: CGFloat = 2
        let image = loadTortoise(scale: scale)
        let canvas = Canvas(size: CGSize(width: 300, height: 300), scale: scale, tortoise: image)

        canvas.🐢
            .setRGB(0, [0.8, 0.8, 0.8])
            .make("color", 0)
            .repeat(12) { $0
                .setPenWidth(2)
                .right(15)
                .repeat(6) { $0
                    .setPenColor { $0.penColor + 1 }
                    .forward(50)
                    .right(60)
                }
                .setPenWidth(1)
                .right(15)
                .repeat(6) { $0
                    .make("color") { $0["color"] + 1 }
                    .setPenColor { $0["color"] }
                    .forward(20)
                    .right(60)
                }
            }
            .setPenColor(1)
            .home()

        var images: [CGImage] = []
        canvas.draw(oneByOne: { images.append($0) })
        XCTAssert(!images.isEmpty)

        let pngURL = URL(fileURLWithPath: "./example.png")
        let gifURL = URL(fileURLWithPath: "./example.gif")

        // swiftlint:disable force_unwrapping
        let pngDestination = CGImageDestinationCreateWithURL(pngURL as CFURL, kUTTypePNG, 1, nil)
        XCTAssertNotNil(pngDestination)
        CGImageDestinationAddImage(pngDestination!, images.last!, nil)
        CGImageDestinationFinalize(pngDestination!)

        let gifDestination = CGImageDestinationCreateWithURL(gifURL as CFURL, kUTTypeGIF, images.count, nil)
        XCTAssertNotNil(gifDestination)
        images.forEach {
            CGImageDestinationAddImage(gifDestination!, $0, nil)
        }
        CGImageDestinationFinalize(gifDestination!)
        // swiftlint:enable force_unwrapping
    }

    static var allTests = [
        ("testOutputExample", testOutputExample)
    ]

}
