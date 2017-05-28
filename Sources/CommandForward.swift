//
//  CommandForward.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/27.
//  Copyright © 2017 temoki. All rights reserved.
//

import CoreGraphics

class CommandForward: Command {
    
    private let distance: CGFloat
    
    init(distance: CGFloat) {
        self.distance = distance
    }
    
    // MARK: - TortoiseCommand protocol
    
    func test(in state: State) -> State {
        var newState = state
        let transform = CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: -state.heading * .pi / 180)
        newState.position = CGPoint(x: 0, y: distance).applying(transform)
        return newState
    }
    
    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        if newState.isPenDown {
            context.addLine(to: newState.position)
            context.strokePath()
        }
        context.move(to: newState.position)
        return newState
    }
    
}
