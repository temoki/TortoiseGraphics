<img src="https://temoki.github.io/TortoiseGraphics/playground-subscription-feed/main/banner.png" />

[![Swift](https://img.shields.io/badge/Swift-5.1-blue.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.1-blue.svg)]()
[![Swift Playgrounds](https://img.shields.io/badge/Swift_Playgrounds-available-blue.svg)](https://swift.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/TortoiseGraphics.svg?style=flat)](http://cocoapods.org/pods/TortoiseGraphics)
[![License](https://img.shields.io/cocoapods/l/TortoiseGraphics.svg?style=flat)](http://cocoapods.org/pods/TortoiseGraphics)
[![Platform](https://img.shields.io/cocoapods/p/TortoiseGraphics.svg?style=flat)](http://cocoapods.org/pods/TortoiseGraphics)

A  [turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics) (a key feature of the [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)) engine written in Swift.

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

<img src="https://temoki.github.io/TortoiseGraphics/images/example.png" width="300" />

## Usage

```swift
// Instantiate a `Tortoise`
let 🐢 = Tortoise()

// Instantiate `ImageCanvas` and add the tortoise
let canvas = ImageCanvas(size: Vec2D(300, 300))
canvas.add(🐢)

// Command 🐢
🐢.right(90)
🐢.forward(100)

// Get drawn `CGImage`
let cgImage = canvas.cgImage

```

## Playgrounds

### On Xcode

1. Open `TortoiseGraphics.xcworkspace` in Xcode.
1. Build `TortoiseGraphics` scheme for iOS Simulator.
1. Select `Playground` in project navigator.
1. Let's play!

### On Swift Playgrounds (iPad app)

<img src="https://temoki.github.io/TortoiseGraphics/images/swift_playgrounds_mov.gif" />

#### Subscription

1. Launch Safari on your iPad and browse this page.
1. Tap the following link to subscribe.
    * [Subscribe in Swift Playgrounds](https://developer.apple.com/ul/sp0?url=https://temoki.github.io/TortoiseGraphics/playground-subscription-feed/locales.json)
1. You can get _Tortoise Graphics_ playground book on Swift Playgrounds app.

#### Download

1. Download `TortoiseGraphics.playgroundbook.zip` from [here](https://github.com/temoki/TortoiseGraphics/releases).
1. Unarchive the downloaded zip file.
1. Send the unarchvied `TortoiseGraphics.playgroundbook` file to your iPad by AirDrop.
1. Open it with Swift Playgrounds app.
1. Let's play!

## Classes

* `Tortoise`
* `ImageCanvas`
* `Shape`
* `Color`
* `Vec2D`

## Enums

* `Speed`

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
* `circle()`

#### Tell tortoise's state

* `position`, `pos`
* `towards()`
* `xcor`
* `ycor`
* `heading`
* `distance()`

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
* `shape()`
* `shape`

## Other Commands

* `repeating() {}`
* `random()`
* `degrees()`
* `radians()`
* `colorMode()`, 
* `colorMode`

## for Playground

* `PlaygroundCanvas`
* `PlaygroundCanvasLiveView`

### for Swift Playgrounds

* `SwiftPlaygroundCanvas`
* `LiveViewController`

## Requirements

* Swift 5.1 (Xcode 11.1)
* iOS 12.0 or later

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

```
github "temoki/TortoiseGraphics"
```

### [Cocoapods](https://github.com/cocoapods/cocoapods)

```ruby
pod 'TortoiseGraphics'
```

## Remaining Work

* support SVG output 
* macOS support
* [Swift Package Manager](https://swift.org/package-manager/) support
* Enrich tortoise commands
* Enrich playground contents

## Credits

* Special thanks to [@kiyoshifuwa](https://twitter.com/kiyoshifuwa), for the amazing art works.

## License

TortoiseGraphics is released under the MIT license. See LICENSE for details.
