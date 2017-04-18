//
//  CommandHome.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

class CommandHome: Command {

    func execute(context: Context) {
        context.position = Context.defaultPosition
        context.heading = Context.defaultHeading
    }

    var isGraphicsCommand: Bool {
        return true
    }

}
