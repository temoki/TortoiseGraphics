//
//  CommandArc.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandArc: Command {

    private let angle: NumberOutput
    private let radius: NumberOutput

    init(angle: @escaping NumberOutput, radius: @escaping NumberOutput) {
        self.angle = angle
        self.radius = radius
    }

    func execute(context: Context) {
        guard context.penDown else { return }
        let angle = self.angle(Properties(context: context))
        let radius = self.radius(Properties(context: context))

        // Current position = Center of Arc
        let center = context.position

        // Arc start position
        let transform = CGAffineTransform(translationX: center.x, y: center.y)
            .rotated(by: context.heading.radian)
        let startPos = CGPoint(x: radius, y: 0).applying(transform)

        // Arc start and end angle
        let startAngle = context.heading.radian
        let endAngle = startAngle - angle.radian

        // Draw
        context.bitmapContext.move(to: startPos)
        context.bitmapContext.addArc(center: center, radius: radius,
                                     startAngle: startAngle, endAngle: endAngle, clockwise: true)
        context.bitmapContext.strokePath()

        // Back to current position
        context.position = center
    }

    var isGraphicsCommand: Bool {
        return true
    }

}
