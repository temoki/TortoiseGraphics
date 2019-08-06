import CoreGraphics

extension CGPoint {

    func toCGPath() -> CGPath {
        let cgPath = CGMutablePath()
        cgPath.move(to: self)
        cgPath.addLine(to: self)
        return cgPath
    }

    func distance(to other: CGPoint) -> CGFloat {
        let diffX = other.x - x
        let diffY = other.y - y
        return (diffX * diffX + diffY * diffY).squareRoot()
    }

}

extension Array where Element == CGPoint {

    func toCGPath() -> CGPath {
        let cgPath = CGMutablePath()
        for (index, point) in self.enumerated() {
            if index == 0 {
                cgPath.move(to: point)
            } else {
                cgPath.addLine(to: point)
            }
        }
        return cgPath
    }

}
