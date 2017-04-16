//
//  CommandCall.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/25.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandCall: Command {

    let name: String
    let parameters: [String: NumberOutput]

    init(name: String, parameters: [String: NumberOutput]) {
        self.name = name
        self.parameters = parameters
    }

    func execute(context: Context) {
        guard let procedure = context.procedures[name] else { return }
        let properties = Properties(context: context)
        parameters.forEach { (parameter) in
            procedure.variables[parameter.key] = parameter.value(properties)
        }
        procedure.doExecute(context: context)
    }

}
