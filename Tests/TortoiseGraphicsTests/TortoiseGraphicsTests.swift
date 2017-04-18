import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {

    func testExample() {
        let canvas = Canvas(size: CGSize(width: 300, height: 300))

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

        let path = NSHomeDirectory().appending("/Desktop/TortoiseGraphicsExample")
        let pngURL = URL(fileURLWithPath: path.appending(".png"))
        let gifURL = URL(fileURLWithPath: path.appending(".gif"))

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
        ("testExample", testExample)
    ]

}
