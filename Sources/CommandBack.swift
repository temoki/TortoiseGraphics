import CoreGraphics

class CommandBack: CommandForward {
    
    override init(distance: CGFloat) {
        super.init(distance: -distance)
    }
    
}
