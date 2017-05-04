//
//  CommandDot.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/12.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandDot: Command {

    private let x: NumberOutput
    private let y: NumberOutput

    init(x: @escaping NumberOutput, y: @escaping NumberOutput) {
        self.x = x
        self.y = y
    }

    func execute(context: Context) {
        if context.penDown {
            let posX = x(Properties(context: context))
            let posY = y(Properties(context: context))
            let dotRect = CGRect(x: posX - (context.penWidth / 2),
                                 y: posY - (context.penWidth / 2),
                                 width: context.penWidth,
                                 height: context.penWidth)
                .applying(CGAffineTransform(scaleX: context.canvasScale, y: context.canvasScale))
            context.bitmapContext.fillEllipse(in: dotRect)
        }
    }

    var isGraphicsCommand: Bool {
        return true
    }

}
