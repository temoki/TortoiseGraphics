//
//  Tortoise.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/26.
//
//

import Foundation
import CoreGraphics

public class Tortoise {
    
    var state = State()
    
    var commands: [Command] = []
    
    func add(command: Command) {
        state = command.test(in: state)
        commands.append(command)
    }
    
    @discardableResult
    func run(with context: GraphicsContext, toFrame index: Int? = nil) -> Int? {
        let endIndex = commands.count - 1
        let toIndex = min(max((index ?? endIndex), 0), endIndex)
        
        var state = State()
        context.setup(in: state)
        
        for (index, command) in commands.enumerated() where index <= toIndex {
            state = command.exexute(in: state, with: context.cgContext)
        }
        
        context.tearDown()
        return toIndex < endIndex ? toIndex + 1 : nil
    }
    
}

public extension Tortoise {
    
    public func forward(_ distance: Double) {
        add(command: CommandForward(distance: CGFloat(distance)))
    }
    
    public func back(_ distance: Double) {
        add(command: CommandBack(distance: CGFloat(distance)))
    }
    
    public func right(_ angle: Double) {
        add(command: CommandRight(angle: CGFloat(angle)))
    }

    public func left(_ angle: Double) {
        add(command: CommandLeft(angle: CGFloat(angle)))
    }
    
}

public extension Tortoise {
 
    var position: (x: Double, y: Double) {
        return (x: Double(state.position.x), y: Double(state.position.y))
    }
    
    var heading: Double {
        return Double(state.heading)
    }

}

