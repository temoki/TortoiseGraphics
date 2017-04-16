//
//  CommandSetBackground.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/21.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetBackground: Command {

    private let number: NumberOutput

    init(number: @escaping NumberOutput) {
        self.number = number
    }

    func execute(context: Context) {
        context.backgroundColor = number(Properties(context: context)).integer
    }

}
