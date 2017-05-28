//
//  CommandLeft.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/28.
//  Copyright © 2017 temoki. All rights reserved.
//

import CoreGraphics

class CommandLeft: CommandRight {
    
    override init(angle: CGFloat) {
        super.init(angle: -angle)
    }

}
