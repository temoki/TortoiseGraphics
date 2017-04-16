//
//  CommandRight.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandRight: CommandLeft {

    override func angleOutput(context: Context) -> Number {
        return -super.angleOutput(context: context)
    }

}
