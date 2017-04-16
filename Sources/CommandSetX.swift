//
//  CommandSetX.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetX: Command {

    private let x: NumberOutput

    init(_ x: @escaping NumberOutput) {
        self.x = x
    }

    func execute(context: Context) {
        let position = CGPoint(x: x(Properties(context: context)),
                               y: context.position.y)
        if context.penDown {
            context.bitmapContext.addLine(to: position)
            context.bitmapContext.strokePath()
        }
        context.position = position
    }

}
