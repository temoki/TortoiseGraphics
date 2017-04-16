//
//  CommandSetHeading.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetHeading: Command {

    private let angle: NumberOutput

    init(angle: @escaping NumberOutput) {
        self.angle = angle
    }

    func execute(context: Context) {
        let angle = self.angle(Properties(context: context))
        context.heading = Context.defaultHeading - angle
    }

}
