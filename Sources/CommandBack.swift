//
//  CommandBack.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/27.
//  Copyright © 2017 temoki. All rights reserved.
//

import CoreGraphics

class CommandBack: CommandForward {
    
    override init(distance: CGFloat) {
        super.init(distance: -distance)
    }
    
}
