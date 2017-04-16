//
//  CommandLocal.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/25.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandLocal: Command {

    let variableName: String
    let number: NumberOutput

    init(variableName: String, number: @escaping NumberOutput) {
        self.variableName = variableName
        self.number = number
    }

    func execute(context: Context) {
        if !context.variablesStack.isEmpty {
            let last = context.variablesStack.count - 1
            context.variablesStack[last][variableName] = number(Properties(context: context))
        }
    }

}
