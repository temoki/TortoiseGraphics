//
//  CGPointArray+.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/22.
//

import CoreGraphics

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

extension CGPoint {

    func toCGPath() -> CGPath {
        let cgPath = CGMutablePath()
        cgPath.move(to: self)
        cgPath.addLine(to: self)
        return cgPath
    }

}
