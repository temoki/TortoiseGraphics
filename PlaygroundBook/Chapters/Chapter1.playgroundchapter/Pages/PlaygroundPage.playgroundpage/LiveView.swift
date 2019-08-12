import UIKit
import PlaygroundSupport

let liveView = instantiateLiveView()
let 🐢 = Tortoise("initial")
liveView.canvas.add(🐢)
PlaygroundPage.current.liveView = liveView
