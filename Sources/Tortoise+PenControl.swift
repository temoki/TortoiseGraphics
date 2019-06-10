import Foundation
import CoreGraphics

public extension Tortoise {

    // MARK: - Drawing state

    func penDown() {
        add(command: CommandPenDown(true))
    }

    func pd() {
        penDown()
    }

    func down() {
        penDown()
    }

    func penUp() {
        add(command: CommandPenDown(false))
    }

    func pu() {
        penUp()
    }

    func up() {
        penUp()
    }

    func penSize(_ size: Double) {
        add(command: CommandPenSize(CGFloat(size)))
    }

    func width(_ width: Double) {
        penSize(width)
    }

    var isDown: Bool {
        return testState.isPenDown
    }

    var penSize: Double {
        return Double(testState.penSize)
    }

    var width: Double {
        return penSize
    }

    // MARK: - Color control

    func penColor(_ color: Color) {
        add(command: CommandColor(.pen, color: color))
    }

    func penColor(_ r: Double, _ g: Double, _ b: Double) {
        add(command: CommandColor(.pen, red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255)))
    }

    func penColor(_ rgb: (r: Double, g: Double, b: Double)) {
        add(command: CommandColor(.pen, red: CGFloat(rgb.r/255), green: CGFloat(rgb.g/255), blue: CGFloat(rgb.b/255)))
    }

    var penColor: (r: Double, g: Double, b: Double) {
        let rgb = testState.penColor.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    func fillColor(_ color: Color) {
        add(command: CommandColor(.fill, color: color))
    }

    func fillColor(_ r: Double, _ g: Double, _ b: Double) {
        add(command: CommandColor(.fill, red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255)))
    }

    func fillColor(_ rgb: (r: Double, g: Double, b: Double)) {
        add(command: CommandColor(.fill, red: CGFloat(rgb.r/255), green: CGFloat(rgb.g/255), blue: CGFloat(rgb.b/255)))
    }

    var fillColor: (r: Double, g: Double, b: Double) {
        let rgb = testState.fillColor.rgb
        return (r: Double(rgb.0*255), g: Double(rgb.1*255), b: Double(rgb.2*255))
    }

    // MARK: - Filling

    var filling: Bool {
        return testState.fillPath != nil
    }

    func beginFill() {
        add(command: CommandFill(.begin))
    }

    func endFill() {
        add(command: CommandFill(.end))
    }

    // MARK: - More drawing control

    func reset() {
        add(command: CommandReset())
    }

    func clear() {
        add(command: CommandClear())
    }

}
