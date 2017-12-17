import Foundation
import CoreGraphics

public extension Tortoise {

    // MARK: - Drawing state

    public func penDown() {
        add(command: CommandPenDown(true))
    }

    public func pd() {
        penDown()
    }

    public func down() {
        penDown()
    }

    public func penUp() {
        add(command: CommandPenDown(false))
    }

    public func pu() {
        penUp()
    }

    public func up() {
        penUp()
    }

    public func penSize(_ size: Double) {
        add(command: CommandPenSize(CGFloat(size)))
    }

    public func width(_ width: Double) {
        penSize(width)
    }

    public var isDown: Bool {
        return testState.isPenDown
    }

    public var penSize: Double {
        return Double(testState.penSize)
    }

    public var width: Double {
        return penSize
    }

    // MARK: - Color control

    public func penColor(_ color: Color) {
        add(command: CommandColor(.pen, color: color))
    }

    public func penColor(_ r: Double, _ g: Double, _ b: Double) {
        add(command: CommandColor(.pen, red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255)))
    }

    public func penColor(_ rgb: (r: Double, g: Double, b: Double)) {
        add(command: CommandColor(.pen, red: CGFloat(rgb.r/255), green: CGFloat(rgb.g/255), blue: CGFloat(rgb.b/255)))
    }

    public var penColor: (r: Double, g: Double, b: Double) {
        let rgb = testState.penColor.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    public func fillColor(_ color: Color) {
        add(command: CommandColor(.fill, color: color))
    }

    public func fillColor(_ r: Double, _ g: Double, _ b: Double) {
        add(command: CommandColor(.fill, red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255)))
    }

    public func fillColor(_ rgb: (r: Double, g: Double, b: Double)) {
        add(command: CommandColor(.fill, red: CGFloat(rgb.r/255), green: CGFloat(rgb.g/255), blue: CGFloat(rgb.b/255)))
    }

    public var fillColor: (r: Double, g: Double, b: Double) {
        let rgb = testState.fillColor.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    // MARK: - Filling

    public var filling: Bool {
        return testState.fillPath != nil
    }

    public func beginFill() {
        add(command: CommandFill(.begin))
    }

    public func endFill() {
        add(command: CommandFill(.end))
    }

    // MARK: - More drawing control

    public func reset() {
        add(command: CommandReset())
    }

    public func clear() {
        add(command: CommandClear())
    }

}
