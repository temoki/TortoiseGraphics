import CoreGraphics

struct Degree {

    let degree: CGFloat

    init(_ degree: CGFloat) {
        self.degree = degree
    }

    var radian: CGFloat {
        return degree * .pi / 180
    }

}

struct Radian {

    let radian: CGFloat

    init(_ radian: CGFloat) {
        self.radian = radian
    }

    var degree: CGFloat {
        return radian * 180 / .pi
    }

}
