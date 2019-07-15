//
//  CommandDot.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/12.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandDot: Command {

    private let size: CGFloat?

    init(size: CGFloat? = nil) {
        self.size = size
    }

    func test(in state: State) -> State {
        return state
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = test(in: state)
        let dotSize = size ?? max(newState.penSize + 4, 2 * newState.penSize)
        let dotRect = CGRect(x: newState.position.x - (dotSize / 2),
                             y: newState.position.y - (dotSize / 2),
                             width: dotSize,
                             height: dotSize)
        context.saveGState()
        context.setFillColor(newState.penColor)
        context.fillEllipse(in: dotRect)
        context.restoreGState()
        return newState
    }

}
