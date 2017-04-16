//
//  CommandLeft.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandLeft: Command {

    private let angle: NumberOutput

    func angleOutput(context: Context) -> Number {
        return angle(Properties(context: context))
    }

    init(angle: @escaping NumberOutput) {
        self.angle = angle
    }

    func execute(context: Context) {
        context.heading += angleOutput(context: context)
    }

}
