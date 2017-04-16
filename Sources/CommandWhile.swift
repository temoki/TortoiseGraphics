//
//  CommandWhile.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/27.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandWhile: Command {

    let condition: BoolOutput
    let procedure: Procedure

    init(condition: @escaping BoolOutput, procedure: Procedure) {
        self.condition = condition
        self.procedure = procedure
    }

    func execute(context: Context) {
        while condition(Properties(context: context)) {
            procedure.doExecute(context: context)
        }
    }

}
