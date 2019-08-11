import UIKit
import PlaygroundSupport

let liveView = instantiateLiveView()
let initialTortoise = Tortoise("initial")
liveView.canvas.add(initialTortoise)
PlaygroundPage.current.liveView = liveView
