//#-hidden-code
//#-end-hidden-code
import Foundation
import PlaygroundSupport

let canvas = SwiftPlaygroundCanvas()
let 🐢 = Tortoise()
canvas.add(🐢)

🐢.repeat(4) {
    🐢.forward(100)
    🐢.right(90)
}
