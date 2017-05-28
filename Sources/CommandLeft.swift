import CoreGraphics

class CommandLeft: CommandRight {
    
    override init(angle: CGFloat) {
        super.init(angle: -angle)
    }

}
