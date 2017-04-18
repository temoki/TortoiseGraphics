//
//  CommandSetY.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetY: Command {

    private let y: NumberOutput

    init(_ y: @escaping NumberOutput) {
        self.y = y
    }

    func execute(context: Context) {
        let position = CGPoint(x: context.position.x,
                               y: y(Properties(context: context)))
        if context.penDown {
            context.bitmapContext.addLine(to: position)
            context.bitmapContext.strokePath()
        }
        context.position = position
    }

    var isGraphicsCommand: Bool {
        return true
    }

}
