//
//  CommandBack.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/10.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandBack: CommandForward {

    override func distanceOutput(context: Context) -> Number {
        return -super.distanceOutput(context: context)
    }

}
