//
//  CommandSetPenColor.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetPenColor: Command {

    private let number: NumberOutput

    init(number: @escaping NumberOutput) {
        self.number = number
    }

    func execute(context: Context) {
        context.penColor = number(Properties(context: context)).integer
    }

}
