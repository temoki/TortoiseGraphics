//
//  CommandIf.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/27.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandIf: Command {

    let condition: BoolOutput
    let thenProcedure: Procedure
    let elseProcedure: Procedure

    init(condition: @escaping BoolOutput, thenProcedure: Procedure, elseProcedure: Procedure) {
        self.condition = condition
        self.thenProcedure = thenProcedure
        self.elseProcedure = elseProcedure
    }

    func execute(context: Context) {
        if condition(Properties(context: context)) {
            thenProcedure.doExecute(context: context)
        } else {
            elseProcedure.doExecute(context: context)
        }
    }

}
