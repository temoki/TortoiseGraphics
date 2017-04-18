//
//  CommandForward.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandForward: Command {

    private let distance: NumberOutput

    func distanceOutput(context: Context) -> Number {
        return distance(Properties(context: context))
    }

    init(distance: @escaping NumberOutput) {
        self.distance = distance
    }

    func execute(context: Context) {
        let transform = CGAffineTransform(translationX: context.position.x, y: context.position.y)
            .rotated(by: context.heading.radian)
        let newPos = CGPoint(x: distanceOutput(context: context), y: 0).applying(transform)
        if context.penDown {
            context.bitmapContext.addLine(to: newPos)
            context.bitmapContext.strokePath()
        }
        context.position = newPos
    }

    var isGraphicsCommand: Bool {
        return true
    }

}
