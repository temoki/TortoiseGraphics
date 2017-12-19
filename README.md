# TortoiseGraphics 🐢

[![Swift](https://img.shields.io/badge/Swift-4.0-blue.svg)](https://swift.org)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/TortoiseGraphics.svg?style=flat)](http://cocoapods.org/pods/TortoiseGraphics)
[![License](https://img.shields.io/cocoapods/l/TortoiseGraphics.svg?style=flat)](http://cocoapods.org/pods/TortoiseGraphics)
[![Platform](https://img.shields.io/cocoapods/p/TortoiseGraphics.svg?style=flat)](http://cocoapods.org/pods/TortoiseGraphics)

A  [turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics) (a key feature of the [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)) ) engine written in Swift.

The commands were implemented with reference to the [turtle in Python 3 standard libraries](https://docs.python.org/3/library/turtle.html).

## Example

```swift
// Turtle Star!
🐢.beginFill()
🐢.repeat(36) {
    🐢.forward(200)
    🐢.left(170)
}
🐢.endFill()
```

### Result

<img src="https://github.com/temoki/TortoiseGraphics/blob/master/OutputExamples/example1.png" width="300" />
<img src="https://github.com/temoki/TortoiseGraphics/blob/master/OutputExamples/example1.gif" width="300" />

## Usage

### Draw in NSView (macOS)

```swift
class CanvasView: NSView {

    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Get current context
        guard let cgContext = NSGraphicsContext.current?.cgContext else { return }

        // Instantiate a GraphicsCanvas
        let canvas = GraphicsCanvas(size: bounds.size, context: context)

        // Command 🐢 on canvas.
        canvas.drawing { 🐢 in
            🐢.right(90)
            🐢.forward(100)
        }
    }

}
```

### Draw in UIView (iOS)

```swift
class CanvasView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Get current context
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Instantiate a GraphicsCanvas
        let canvas = GraphicsCanvas(size: bounds.size, context: context)

        // Command 🐢 on canvas.
        canvas.drawing { 🐢 in
            🐢.right(90)
            🐢.forward(100)
        }
    }

}
```

### Make or Write image

```swift
// Instantiate a ImageCanvas
let canvas = ImageCanvas(size: CGSize(width: 300, height: 300))

// Command 🐢 on canvas
canvas.drawing { 🐢 in
    🐢.right(90)
    🐢.forward(100)
}

// Get drawn CGImage
let cgImage = canvas.cgImage

// Get drawn NSImage or UIImage
let image = canvas.image

// Write to image file (PNG, JPEG, TIFF, GIF)
canvas.writePNG(to: URL(fileURLWithPath: "./image.png")
canvas.writeJPEG(to: URL(fileURLWithPath: "./image.jpeg")
canvas.writeTIFF(to: URL(fileURLWithPath: "./image.tiff")
canvas.writeGIF(to: URL(fileURLWithPath: "./image.gif")
```

### With multiple tortoises

```swift
canvas.drawingWithTortoises(count: 2) { tortoises in
    let 🐢 = tortoises[0]
    let 🐇 = tortoises[1]
    
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
```

<img src="https://github.com/temoki/TortoiseGraphics/blob/master/OutputExamples/example2.png" width="300" />
<img src="https://github.com/temoki/TortoiseGraphics/blob/master/OutputExamples/example2.gif" width="300" />

## Playgrounds

### On Xcode

1. Open `TortoiseGraphics.xcworkspace` in Xcode.
1. Build `TortoiseGraphics` scheme.
1. Select `Playground` in project navigator.
1. Let's play!

### On Playgrounds iPad app

1. Download `TortoisePlayground.playgroundbook.zip` from [here](https://github.com/temoki/TortoiseGraphics/releases).
1. Unarchive the downloaded zip file.
1. Send the unarchvied `TortoisePlayground.playgroundbook` file to your iPad by AirDrop.
1. Open it with Playgrounds app.
1. Let's play!

## Classes

* `ImageCanvas`
* `GraphicsCanvas`
* `Tortoise`
* `Vec2D`

## Tortoise Commands

### Motion

#### Move and Draw

* `forward()`, `fd()`
* `backword()`, `back()`, `bk()`
* `right()`, `rt()`
* `left()`, `lt()`
* `setPosition()`, `setPos()`, `goto()`
* `setX()`
* `setY()`
* `setHeading()`, `setH()`
* `home()`
* `dot()`
* `circle()`
* `repeat() {}`

#### Tell tortoise's state

* `position`, `pos`
* `towards()`
* `xcor`
* `ycor`
* `heading`
* `distance()`
* `random()`

### Pen Control

#### Drawing state

* `penDown()`, `pd()`, `down()`
* `penUp()`, `pu()`, `up()`
* `penSize()`
* `width()`
* `isDown`
* `penSize`
* `width`

#### Color control

* `penColor()`
* `penColor`
* `fillColor()`
* `fillColor`

#### Filling

* `filling`
* `beginFill()`
* `endFill()`

#### More drawing control

* `reset()`
* `clear()`

### Tortoise state

#### Visiblity

* `showTortoise()`, `st()`
* `hideTortoise()`, `ht()`
* `isVisible`

## Requirements

* Swift 4 (Xcode 9)
* macOS 10.10 or later
* iOS 10.0 or later

## Installation

### [Swift Package Manager](https://swift.org/package-manager)

```swift
dependencies: [
    .Package(url: "https://github.com/temoki/TortoiseGraphics.git", majorVersion: 0)
]
```

### [Carthage](https://github.com/Carthage/Carthage)

```
github "temoki/TortoiseGraphics"
```

### [Cocoapods](https://github.com/cocoapods/cocoapods)

```ruby
pod 'TortoiseGraphics'
```

## License

TortoiseGraphics is released under the MIT license. See LICENSE for details.
