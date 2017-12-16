import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {

    func testExample() {
        let size = CGSize(width: 300, height: 300)
        let scale = NSScreen.main()?.backingScaleFactor ?? 1
        let canvas = ImageCanvas(size: size, scale: scale)
        canvas.drawing { 🐢 in
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
        }

        XCTAssert(canvas.writePNG(to: URL(fileURLWithPath: "./example.png")))
        XCTAssert(canvas.writeGIF(to: URL(fileURLWithPath: "./example.gif")))
    }

    static var allTests = [
        ("testExample", testExample)
    ]

}
