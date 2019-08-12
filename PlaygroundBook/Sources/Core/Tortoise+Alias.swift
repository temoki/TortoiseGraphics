import Foundation

extension Tortoise {

    /// Alias to `forward()`
    public func fd(_ distance: Double) {
        forward(distance)
    }

    /// Alias to `backward()`
    public func back(_ distance: Double) {
        backword(distance)
    }

    /// Alias to `backward()`
    public func bk(_ distance: Double) {
        backword(distance)
    }

    /// Alias to `right()`
    public func rt(_ angle: Double) {
        right(angle)
    }

    /// Alias to `left()`
    public func lt(_ angle: Double) {
        left(angle)
    }

    /// Alias to `setPosition()`
    public func setPos(_ x: Double, _ y: Double) {
        setPosition(x, y)
    }

    /// Alias to `setPosition()`
    public func goto(_ x: Double, _ y: Double) {
        setPosition(x, y)
    }

    // Alias to `setHeading()`
    public func setH(_ heading: Double) {
        setHeading(heading)
    }

    /// Alias to `penDown()`
    public func pd() {
        penDown()
    }

    /// Alias to `penDown()`
    public func down() {
        penDown()
    }

    /// Alias to `penUp()`
    public func pu() {
        penUp()
    }

    /// Alias to `penUp()`
    public func up() {
        penUp()
    }

    /// Alias to `penSize()`
    public func width(_ width: Double) {
        penSize(width)
    }

    /// Alias to `penSize`
    public var width: Double {
        return penSize
    }

    /// Alias to `showTortoise()`
    public func st() {
        showTortoise()
    }

    /// Alias to `hideTortoise()`
    public func ht() {
        hideTortoise()
    }

}
