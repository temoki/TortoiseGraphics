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

    /// Whether this command update canvas
    var isGraphicsCommand: Bool { get }

}

extension Command {

    func doExecute(context: Context) {
        execute(context: context)
        guard isGraphicsCommand else { return }
        guard let handler = context.drawingHandler else { return }
        guard let image = context.render() else { return }
        handler(image)
    }

    var isGraphicsCommand: Bool {
        return false
    }

}
