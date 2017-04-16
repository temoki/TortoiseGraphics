//
//  CommandPenDown.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandPenDown: Command {

    private let penDown: Bool

    init(_ penDown: Bool) {
        self.penDown = penDown
    }

    func execute(context: Context) {
        context.penDown = penDown
    }

}
