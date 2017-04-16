# TortoiseGraphics 🐢

A  [turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics) (a key feature of the [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)) ) engine written in Swift.

The commands were implemented with reference to [ACSLogo](http://www.alancsmith.co.uk/logo).

[![Swift](https://img.shields.io/badge/Swift-3.1-blue.svg)](hhttps://swift.org)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)

## Example

```swift
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
```

<img src="https://github.com/temoki/TortoiseGraphics/blob/master/example.png" width="300" />


## Usage

```swift
// Instantiate a canvas.
let canvas = Canvas(size: CGSize(width: 300, height: 300))

// Command 🐢 on canvas.
canvas.🐢.right(90).forward(100).done()

// Draw canvas.
canvas.draw()

// Get rendered image from can.
let image = canvas.rendered
```

## Commands

### Move and Draw

* `cleanScreen`
* `clean`
* `forward`
* `back`
* `right`
* `left`
* `home`
* `setHeading`
* `setPosition`
* `setX`
* `setY`
* `dot`
* `arc`

### Pen and Canvas state

* `penDown`
* `penUp`
* `setPenColor`
* `setPenWidth`
* `setLineCap`
* `setLineDash`
* `setBackground`
* `setRGB`

### Control

* `done`
* `showTortoise`
* `hideTortoise`
* `define`
* `call`
* `repeat`
* `while`
* `if`
* `make`
* `local`
* `print`

### Output

* `random`
* `towards`
* `shown`
* `heading`
* `position`
* `penColor`
* `penWidth`
* `background`
* `rgb`
* `canvasSize`


## Requirements

* Swift 3.1 (Xcode 8.3.1)
* macOS 10.10 or later
* iOS 10.0 or later

## Installation

* Swift Package Manager

## Roadmap

* Carthage/Cocoapods installation

## License

TortoiseGraphics is released under the MIT license. See LICENSE for details.
