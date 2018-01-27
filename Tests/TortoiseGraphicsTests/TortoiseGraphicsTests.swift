import XCTest
@testable import TortoiseGraphics
import CoreGraphics

class TortoiseGraphicsTests: XCTestCase {

    func testWithATortoise() {
        let size = CGSize(width: 300, height: 300)
        let scale = NSScreen.main()?.backingScaleFactor ?? 1
        let canvas = ImageCanvas(size: size, scale: scale)
        canvas.color = .white

        canvas.drawing { 🐢 in
            🐢.penColor(.red)
            🐢.fillColor(.orange)

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

        XCTAssert(canvas.writePNG(to: URL(fileURLWithPath: "./OutputExamples/example1.png")))
        XCTAssert(canvas.writeGIF(to: URL(fileURLWithPath: "./OutputExamples/example1.gif")))
    }

    func testWith2Tortoises() {
        let size = CGSize(width: 300, height: 300)
        let scale = NSScreen.main()?.backingScaleFactor ?? 1
        let canvas = ImageCanvas(size: size, scale: scale)
        canvas.color = .white

        canvas.drawingWithTortoises(count: 2) { tortoises in
            let 🐢 = tortoises[0]
            let 🐇 = tortoises[1]
            🐢.shape(.tortoise)
            🐇.shape(.classic)

            🐢.penColor(.red)
            🐢.fillColor(.orange)
            🐢.left(90)

            🐇.penColor(.purple)
            🐇.fillColor(.lightBlue)
            🐇.right(90)

            // Turtle Star!
            🐢.beginFill()
            🐇.beginFill()
            🐢.repeat(36) {
                🐢.forward(120)
                🐇.forward(120)
                🐢.left(170)
                🐇.right(170)
            }
            🐢.endFill()
            🐇.endFill()
        }

        XCTAssert(canvas.writePNG(to: URL(fileURLWithPath: "./OutputExamples/example2.png")))
        XCTAssert(canvas.writeGIF(to: URL(fileURLWithPath: "./OutputExamples/example2.gif")))
    }

    static var allTests = [
        ("testWithATortoise", testWithATortoise),
        ("testWith2Tortoises", testWith2Tortoises)
    ]

}
