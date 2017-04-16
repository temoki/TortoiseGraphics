//
//  CommandDefine.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/25.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandDefine: Command {

    let name: String
    let procedure: Procedure

    init(name: String, procedure: Procedure) {
        self.name = name
        self.procedure = procedure
    }

    func execute(context: Context) {
        context.procedures[name] = procedure
    }

}
