//
//  CommandMake.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/22.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandMake: Command {

    let variableName: String
    let number: NumberOutput

    init(variableName: String, number: @escaping NumberOutput) {
        self.variableName = variableName
        self.number = number
    }

    func execute(context: Context) {
        if !context.variablesStack.isEmpty {
            context.variablesStack[0][variableName] = number(Properties(context: context))
        }
    }

}
