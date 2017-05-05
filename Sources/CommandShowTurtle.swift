//
//  CommandShowTortoise.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/20.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandShowTortoise: Command {

    private let show: Bool

    init(show: Bool) {
        self.show = show
    }

    func execute(context: Context) {
        context.showTortoise = show
    }

    var isGraphicsCommand: Bool {
        return true
    }

}
