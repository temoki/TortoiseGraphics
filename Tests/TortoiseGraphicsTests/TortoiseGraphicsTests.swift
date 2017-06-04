import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {

    func testExample() {
        let 🐢 = Tortoise()

        🐢.penColor(.blue)

        func hexagon(_ side: Double) {
            🐢.repeat(6) {
                🐢.forward(side)
                🐢.right(60)
            }
        }

        var side: Double = 0
        🐢.repeat(24) {
            side += 3
            hexagon(side)
            🐢.right(15)
        }

        let size = CGSize(width: 300, height: 300)
        let pngURL = URL(fileURLWithPath: "./example.png")
        let gifURL = URL(fileURLWithPath: "./example.gif")
        XCTAssert(🐢.writePNG(of: size, to: pngURL))
        XCTAssert(🐢.writeGIF(of: size, to: gifURL))
    }

    static var allTests = [
        ("testExample", testExample)
    ]

}
