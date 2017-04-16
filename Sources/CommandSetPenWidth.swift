//
//  CommandSetPenWidth.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/12.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandSetPenWidth: Command {

    private let width: NumberOutput

    init(_ width: @escaping NumberOutput) {
        self.width = width
    }

    func execute(context: Context) {
        context.penWidth = width(Properties(context: context))
    }

}
