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

### Drawn image

<img src="https://github.com/temoki/TortoiseGraphics/blob/master/example.png" width="300" />

### Drawing animation

<img src="https://github.com/temoki/TortoiseGraphics/blob/master/example.gif" width="300" />

## Usage

### Draw in view (macOS/iOS)
```swift
// Instantiate a Canvas that is a subclass of NSView/UIView.
let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

// Command 🐢 on canvas.
canvas.play { 🐢 in
    🐢.right(90)
    🐢.forward(100)
}
```
### Make or Write image

```swift
// Instantiate 🐢.
let 🐢 = Tortoise()

// Command 🐢
🐢.right(90)
🐢.forward(100)

// Make NSImage or UIImage
let size = CGSize(width: 300, height: 300)
let image = 🐢.makeImage(of: size)

// Write PNG/JPEG/GIF
🐢.writePNG(of: size, to: URL(fileURLWithPath: "./image.png"))
🐢.writeJPEG(of: size, to: URL(fileURLWithPath: "./image.jpeg"))
🐢.writeGIF(of: size, to: URL(fileURLWithPath: "./image.gif"))
```

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

* `Canvas`
* `Tortoise`
* `Vec2D`

## Commands

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

### Make or Write image

* `makeImage()`
* `writePNG()`
* `writeJPEG()`
* `writeGIF()`

## Requirements

* Swift 3.1 (Xcode 8.3)
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
