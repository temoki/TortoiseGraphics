import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {

    func testExample() {
        let 🐢 = Tortoise()

        🐢.penColor(.red)
        🐢.fillColor(.yellow)

        🐢.penUp()
        🐢.back(100)
        🐢.penDown()
 
        // Turtle Star!
        🐢.beginFill()
        🐢.repeat(36) {
            🐢.forward(200)
            🐢.left(170)
        }
        🐢.endFill()

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
