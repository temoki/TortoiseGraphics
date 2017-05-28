//
//  Command.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/27.
//  Copyright © 2017 temoki. All rights reserved.
//

import CoreGraphics

protocol Command {

    func test(in state: State) -> State
    
    func exexute(in state: State, with context: CGContext) -> State

}
