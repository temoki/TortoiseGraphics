//
//  CommandRight.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/27.
//  Copyright © 2017 temoki. All rights reserved.
//

import CoreGraphics

class CommandRight: Command {
    
    private let angle: CGFloat
    
    init(angle: CGFloat) {
        self.angle = angle
    }
    
    func test(in state: State) -> State {
        var newState = state
        newState.heading += angle
        return newState
    }
    
    func exexute(in state: State, with context: CGContext) -> State {
        return test(in: state)
    }
    
}
