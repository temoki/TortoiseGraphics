import CoreGraphics

struct Degree {

    var value: CGFloat {
        didSet {
            self.value = Degree.correct(self.value)
        }
    }

    init(_ degree: CGFloat) {
        self.value = Degree.correct(degree)
    }

    var radian: Radian {
        return Radian(value * .pi / 180)
    }

    private static func correct(_ value: CGFloat) -> CGFloat {
        let max: CGFloat = 360
        if value < 0 {
            return correct(value + max)
        } else if value >= max {
            return correct(value - max)
        }
        return value
    }

}

struct Radian {

    var value: CGFloat {
        didSet {
            self.value = Radian.correct(self.value)
        }
    }

    init(_ radian: CGFloat) {
        self.value = Radian.correct(radian)
    }

    var degree: Degree {
        return Degree(value * 180 / .pi)
    }

    private static func correct(_ value: CGFloat) -> CGFloat {
        let max: CGFloat = 2 * .pi
        if value < 0 {
            return correct(value + max)
        } else if value >= max {
            return correct(value - max)
        }
        return value
    }

}
