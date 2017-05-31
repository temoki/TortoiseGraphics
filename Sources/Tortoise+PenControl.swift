import Foundation
import CoreGraphics

public extension Tortoise {

    // MARK: - Drawing State

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
        return state.isPenDown
    }

    public var penSize: Double {
        return Double(state.penSize)
    }

    public var width: Double {
        return penSize
    }

    // MARK: - Color control

    public func penColor(_ color: Color) {
        add(command: CommandPenColor(color))
    }

    public func penColor(_ r: Double, _ g: Double, _ b: Double) {
        add(command: CommandPenColor(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255)))
    }

    public func penColor(_ rgb: (r: Double, g: Double, b: Double)) {
        add(command: CommandPenColor(red: CGFloat(rgb.r/255), green: CGFloat(rgb.g/255), blue: CGFloat(rgb.b/255)))
    }

    public var penColor: (r: Double, g: Double, b: Double) {
        let rgb = state.penColor.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    // MARK: - More drawing control    

    public func reset() {
        add(command: CommandReset())
    }

    public func clear() {
        add(command: CommandClear())
    }

}
