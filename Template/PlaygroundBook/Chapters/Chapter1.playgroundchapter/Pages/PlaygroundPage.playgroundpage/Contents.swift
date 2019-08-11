//: # Let's play with 🐢
//#-hidden-code
import Foundation
import PlaygroundSupport

let 🐢 = Tortoise()
let canvas = SwiftPlaygroundCanvas()
canvas.add(🐢)
//#-end-hidden-code

🐢.penUp()
🐢.back(100)
🐢.penDown()

// Turtle Star!
🐢.penColor(.blue)
🐢.fillColor(.deepPurple)
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(200)
    🐢.left(170)
}
🐢.endFill()
