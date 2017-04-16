//
//  CommandSetLineCap.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/22.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetLineCap: Command {

    let lineCap: LineCap

    init(_ lineCap: LineCap) {
        self.lineCap = lineCap
    }

    func execute(context: Context) {
        context.bitmapContext.setLineCap(lineCap)
    }

}
