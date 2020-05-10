// swiftlint:disable identifier_name
import Foundation

extension Tortoise {

    /// Alias to `forward()`
    public func まえへ(_ ながさ: Double) {
        forward(ながさ)
    }

    /// Alias to `backward()`
    public func うしろへ(_ ながさ: Double) {
        backword(ながさ)
    }

    /// Alias to `right()`
    public func みぎへ(_ かくど: Double) {
        right(かくど)
    }

    /// Alias to `left()`
    public func ひだりへ(_ かくど: Double) {
        left(かくど)
    }

    /// Alias to `penDown()`
    public func ぺんをおろせ() {
        penDown()
    }

    /// Alias to `penUp()`
    public func ぺんをあげろ() {
        penUp()
    }

    /// Alias to `setPosition()`
    public func いちは(_ よこ: Double, _ たて: Double) {
        setPosition(よこ, たて)
    }

    /// Alias to `setHeading()`
    public func むきは(_ かくど: Double) {
        setHeading(かくど)
    }

    /// Alias to `home()`
    public func もどれ() {
        setPosition(0, 0)
        setHeading(0)
    }

    /// Alias to `penSize()`
    public func ぺんのおおきさは(_ おおきさ: Double) {
        penSize(おおきさ)
    }

    /// Alias to `penColor()`
    public func ぺんのいろは(_ いろ: ColorPalette) {
        penColor(いろ)
    }

    /// Alias to `penColor()`
    public func ペンのいろは(_ あか: Double, _ みどり: Double, _ あお: Double) {
        penColor(あか, みどり, あお)
    }

}

/// Alias to `repeating()`
public func くりかえせ(_ かいすう: Int, _ block: () -> Void) {
    repeating(かいすう, block)
}
