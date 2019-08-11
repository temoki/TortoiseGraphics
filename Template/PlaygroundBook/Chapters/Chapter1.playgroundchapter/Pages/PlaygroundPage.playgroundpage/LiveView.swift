//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//

import UIKit
import PlaygroundSupport

// Instantiate a new instance of the live view from the book's auxiliary sources and pass it to PlaygroundSupport.
let liveView = instantiateLiveView()
let initialTortoise = Tortoise("initial")
liveView.canvas.add(initialTortoise)
PlaygroundPage.current.liveView = liveView
