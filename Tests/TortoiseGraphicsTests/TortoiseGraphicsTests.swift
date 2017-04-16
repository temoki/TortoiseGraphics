import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {
    
    func testExample() {
        let canvas = Canvas(width: 300, height: 300)
        
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
                    .setPenColor({ $0["color"] })
                    .forward(20)
                    .right(60)
                }
            }
            .setPenColor(1)
            .home()
            .done()
        canvas.draw()

        let image = canvas.rendered
        XCTAssertNotNil(image)

        let path = NSHomeDirectory().appending("/Desktop/TortoiseGraphicsExample.png")
        let url = URL(fileURLWithPath: path)
        let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil)
        XCTAssertNotNil(destination)
        
        CGImageDestinationAddImage(destination!, image!, nil)
        CGImageDestinationFinalize(destination!)
    }

    static var allTests = [
        ("testExample", testExample),
    ]

}
