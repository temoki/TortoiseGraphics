//
//  Command.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

/// Tortoise command
protocol Command {

    /// Execute this command
    func execute(context: Context)

}

extension Command {

    func doExecute(context: Context) {
        execute(context: context)
    }

}
